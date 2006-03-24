Return-Path: <hubert.loewenguth@thales-bm.com>
Received: from thsmsgxrt11p.thalesgroup.com (thsmsgxrt11p.thalesgroup.com
	[192.54.144.134]) by ozlabs.org (Postfix) with ESMTP id E302967B55
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 22:52:41 +1100 (EST)
Received: from thsmsgirt23p.corp.thales (unknown [10.33.231.7])
	by thsmsgxrt11p.thalesgroup.com (Postfix) with ESMTP id 1FD253C0BC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 12:44:21 +0100 (CET)
Message-ID: <4423DB92.5070305@thales-bm.com>
Date: Fri, 24 Mar 2006 12:44:18 +0100
From: "hubert.loewenguth" <hubert.loewenguth@thales-bm.com>
MIME-Version: 1.0
To: Siju Viswanath K E <siju@india.tejasnetworks.com>
Subject: Re: "transmit timed out" on FCC in MPC8260 => bug corrected
References: <20060324075148.4C106353BFB@atlas.denx.de>
	<1143193658.22246.20.camel@Blaze>
In-Reply-To: <1143193658.22246.20.camel@Blaze>
Content-Type: multipart/mixed; boundary="------------070203030109060505010200"
Cc: "Hunter, David" <David.Hunter@ipc.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070203030109060505010200
Content-Type: multipart/alternative;
 boundary="------------080001040902070902030304"


--------------080001040902070902030304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi to the community.

I'm the man who has posted numerous questions about this problem of=20
fcc_enet timeout in ppc8260.
I just want to say that the 2.6 kernel doesn't solve the problem if you=20
have it on your board (I tried it,  normally I have a 2.4-20 linux too).
I have search for this bug during a long time, and fortunatly, I 'm=20
happy to say you that finally, it is corrected since few days.
Special thanks to "Hunter, David" for having take in consideration my=20
problem, and proposing me some way of invastigations in this thread:

http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021842.html

In fact the solution comes from the new "MPC8260 PowerQUICC II Family=20
Reference Manual"   fresescale has delivered 01/19/2006.
http://www.freescale.com/files/product/doc/MPC8260UM.pdf

They have added a very interesting paragraph about error handling in=20
ethernet mode:

/29.10.1.3 Adjusting Transmitter BD Handling
When a TXE event occurs, the TBPTR may already point beyond BDs still=20
marked as ready due to internal
pipelining. If the TBPTR is not adjusted, these BDs would be skipped=20
while still being marked as ready.
Software must determine if these BDs should be retransmitted or if they=20
should be skipped, depending on
the protocol and application needs. This requires the following steps:
1. From the current TBPTR value, search backwards over all (if any) BDs=20
still marked as ready to
find the first BD that has not been closed by the CPM. The search=20
process should stop if the BD to
be checked next is not ready or if it is the most recent BD marked as=20
ready by the CPU transmit
software. This is to avoid an endless loop in case the CPU software=20
fills the BD ring completely.
2. A) For skipping BDs, manually close all BDs from the BD just found up=20
to and including the BD
just before TBPTR. Leave the TBPTR value untouched.
B) For retransmitting BDs, change the TBPTR value to point to the BD=20
just found.
/
So, here is the correction  I have done to the fcc-enet.c driver, and=20
wich I'am very satsify
I have tested it on my platform which was always entering in this=20
infernal timeout loop when there was successive plug/unplug during=20
important data transfert.
Thanks to some trace, I have seen that, as it is said in the new manual,=20
the error comes from the pipelining and a bad restart procedure in the=20
driver.
(I think it is the same restart procedure in the 2.6 kernel ??? to=20
verify ...)
With this correction, I have no more infernal timeout  loop.
In fact, I replace the restart procedure in the fcc_enet_interrupt=20
method by this one, which respect the MPC8260 manual restart procedure:

if (must_restart) {
        volatile cpm8260_t *cp;

        /* Some transmit errors cause the transmitter to shut
         * down.  We now issue a restart transmit.  Since the
         * errors close the BD and update the pointers, the restart
         * _should_ pick up without having to reset any of our
         * pointers either.  Also, To workaround 8260 device erratum
         * CPM37, we must disable and then re-enable the transmitter
         * following a Late Collision, Underrun, or Retry Limit error.
         */
        =20
         // disable Transmitter
        cep->fccp->fcc_gfmr &=3D ~FCC_GFMR_ENT;
        udelay(10); /* wait a few microseconds just on principle */
  =20
        #ifdef THALES_DEBUG_TRACE
        printk("Thales restart debug trace :\n");
        printk("first dirty tx %d, final dirty_tx %d, tbptr=20
%d\n",cbt_ptr2index(dev,first_bdp_dirty_tx),cbt_ptr2index(dev,cep->dirty_=
tx),tbptr_ptr2index(dev,ep->fen_genfcc.fcc_tbptr));
        #endif
                                  =20
        // RESTART TX command to the cpm
        cp =3D cpmp;
        cp->cp_cpcr =3D mk_cr_cmd(cep->fip->fc_cpmpage,=20
cep->fip->fc_cpmblock,0x0c, CPM_CR_RESTART_TX) | CPM_CR_FLG;
        while (cp->cp_cpcr & CPM_CR_FLG);
      =20
        // Adjusting Transmitter BD Handling
        /* HLO : I do not search backwards from the current TBPTR value=20
to found skip BDs, but I directly
         * adjust the tbptr value to the dirty_tx current value.
         * In case of problemes occuring, change it and do like=20
indicated in 29.10.3 of MPC8260 manual
         */
        ep->fen_genfcc.fcc_tbptr =3D __pa(cep->dirty_tx);
      =20
        #ifdef THALES_DEBUG_TRACE
        printk(" Thales workaround tbptr value adjusted :=20
%d\n",tbptr_ptr2index(dev,ep->fen_genfcc.fcc_tbptr));
        #endif
      =20
        // re-enable Transmitter      =20
        cep->fccp->fcc_gfmr |=3D  FCC_GFMR_ENT;

        }

I hope this correction will help you and the community.

Best regards


Siju Viswanath K E a =E9crit :

>Hi Denk,
>	Thanks for the suggestion. I had a look at the source repository
>at projects/linuxppc_2_4_devel.git site. Outdated code doesnt seem to be
>the issue. My repository is patched upto=20
>"Patch by Wojciech Kromer, 06 Jan 2004" and later changes are only
>adding extra board support.=20
>
>regards,
>Siju Viswanath
>
>On Fri, 2006-03-24 at 13:21, Wolfgang Denk wrote:
> =20
>
>>In message <1143177651.22246.3.camel@Blaze> you wrote:
>>   =20
>>
>>>	I am using denk's linuxppc-2.4.20 . I am getting this problem of
>>>     =20
>>>
>>Why don't you try using a more current version of the code? 2.4.20 is
>>*very* old, and *lots* of bugs and problems have been fixed since.
>>
>>It really does not make sense to spend effort on such old code.
>>
>>Best regards,
>>
>>Wolfgang Denk
>>   =20
>>
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> =20
>

--------------080001040902070902030304
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi to the community.<br>
<br>
I'm the man who has posted numerous questions about this problem of
fcc_enet timeout in ppc8260.<br>
I just want to say that the 2.6 kernel doesn't solve the problem if you
have it on your board (I tried it,&nbsp; normally I have a 2.4-20 linux too).<br>
I have search for this bug during a long time, and fortunatly, I 'm
happy to say you that finally, it is corrected since few days. <br>
Special thanks to "Hunter, David" for having take in consideration my
problem, and proposing me some way of invastigations in this thread:<br>
<br>
<a class="moz-txt-link-freetext" href="http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021842.html">http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021842.html</a><br>
<br>
In fact the solution comes from the new "MPC8260 PowerQUICC II Family
Reference Manual" &nbsp; fresescale has delivered 01/19/2006.<br>
<a class="moz-txt-link-freetext" href="http://www.freescale.com/files/product/doc/MPC8260UM.pdf">http://www.freescale.com/files/product/doc/MPC8260UM.pdf</a><br>
<br>
They have added a very interesting paragraph about error handling in
ethernet mode:<br>
<br>
<i>29.10.1.3 Adjusting Transmitter BD Handling<br>
When a TXE event occurs, the TBPTR may already point beyond BDs still
marked as ready due to internal<br>
pipelining. If the TBPTR is not adjusted, these BDs would be skipped
while still being marked as ready.<br>
Software must determine if these BDs should be retransmitted or if they
should be skipped, depending on<br>
the protocol and application needs. This requires the following steps:<br>
1. From the current TBPTR value, search backwards over all (if any) BDs
still marked as ready to<br>
find the first BD that has not been closed by the CPM. The search
process should stop if the BD to<br>
be checked next is not ready or if it is the most recent BD marked as
ready by the CPU transmit<br>
software. This is to avoid an endless loop in case the CPU software
fills the BD ring completely.<br>
2. A) For skipping BDs, manually close all BDs from the BD just found
up to and including the BD<br>
just before TBPTR. Leave the TBPTR value untouched.<br>
B) For retransmitting BDs, change the TBPTR value to point to the BD
just found.<br>
</i><br>
So, here is the correction&nbsp; I have done to the fcc-enet.c driver, and
wich I'am very satsify<br>
I have tested it on my platform which was always entering in this
infernal timeout loop when there was successive plug/unplug during
important data transfert.<br>
Thanks to some trace, I have seen that, as it is said in the new
manual, the error comes from the pipelining and a bad restart procedure
in the driver.<br>
(I think it is the same restart procedure in the 2.6 kernel ??? to
verify ...)<br>
With this correction, I have no more infernal timeout&nbsp; loop. <br>
In fact, I replace the restart procedure in the fcc_enet_interrupt
method by this one, which respect the MPC8260 manual restart procedure:<br>
<br>
<font face="Times New Roman, Times, serif"><small>if (must_restart) {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; volatile cpm8260_t *cp;<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Some transmit errors cause the transmitter to shut<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* down.&nbsp; We now issue a restart transmit.&nbsp; Since the<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* errors close the BD and update the pointers, the restart<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* _should_ pick up without having to reset any of our<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* pointers either.&nbsp; Also, To workaround 8260 device erratum <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* CPM37, we must disable and then re-enable the transmitter<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* following a Late Collision, Underrun, or Retry Limit error.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*/<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;// disable Transmitter <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cep-&gt;fccp-&gt;fcc_gfmr &amp;= ~FCC_GFMR_ENT;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; udelay(10); /* wait a few microseconds just on principle */<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #ifdef THALES_DEBUG_TRACE <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk("Thales restart debug trace :\n");<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk("first dirty tx %d, final dirty_tx %d, tbptr
%d\n",cbt_ptr2index(dev,first_bdp_dirty_tx),cbt_ptr2index(dev,cep-&gt;dirty_tx),tbptr_ptr2index(dev,ep-&gt;fen_genfcc.fcc_tbptr));<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #endif<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // RESTART TX command to the cpm<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cp = cpmp;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cp-&gt;cp_cpcr = mk_cr_cmd(cep-&gt;fip-&gt;fc_cpmpage,
cep-&gt;fip-&gt;fc_cpmblock,0x0c, CPM_CR_RESTART_TX) | CPM_CR_FLG;<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; while (cp-&gt;cp_cpcr &amp; CPM_CR_FLG);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // Adjusting Transmitter BD Handling<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* HLO : I do not search backwards from the current TBPTR value
to found skip BDs, but I directly <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* adjust the tbptr value to the dirty_tx current value.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;* In case of problemes occuring, change it and do like
indicated in 29.10.3 of MPC8260 manual<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;*/<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ep-&gt;fen_genfcc.fcc_tbptr = __pa(cep-&gt;dirty_tx);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #ifdef THALES_DEBUG_TRACE <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printk(" Thales workaround tbptr value adjusted :
%d\n",tbptr_ptr2index(dev,ep-&gt;fen_genfcc.fcc_tbptr));<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #endif<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; // re-enable Transmitter&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cep-&gt;fccp-&gt;fcc_gfmr |=&nbsp; FCC_GFMR_ENT;<br>
<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
</small></font><br>
I hope this correction will help you and the community.<br>
<br>
Best regards<br>
<br>
<br>
Siju Viswanath K E a &eacute;crit&nbsp;:
<blockquote cite="mid1143193658.22246.20.camel@Blaze" type="cite">
  <pre wrap="">Hi Denk,
	Thanks for the suggestion. I had a look at the source repository
at projects/linuxppc_2_4_devel.git site. Outdated code doesnt seem to be
the issue. My repository is patched upto 
"Patch by Wojciech Kromer, 06 Jan 2004" and later changes are only
adding extra board support. 

regards,
Siju Viswanath

On Fri, 2006-03-24 at 13:21, Wolfgang Denk wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">In message &lt;1143177651.22246.3.camel@Blaze&gt; you wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">	I am using denk's linuxppc-2.4.20 . I am getting this problem of
      </pre>
    </blockquote>
    <pre wrap="">Why don't you try using a more current version of the code? 2.4.20 is
*very* old, and *lots* of bugs and problems have been fixed since.

It really does not make sense to spend effort on such old code.

Best regards,

Wolfgang Denk
    </pre>
  </blockquote>
  <pre wrap=""><!---->
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

  </pre>
</blockquote>
</body>
</html>

--------------080001040902070902030304--

--------------070203030109060505010200
Content-Type: text/x-vcard; charset=utf-8;
 name="hubert.loewenguth.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hubert.loewenguth.vcf"

begin:vcard
fn:Hubert Loewenguth
n:Loewenguth;Hubert
org:Thales Broadcast & Multimedia
adr:;;1 rue de l'hautil;Conflans Ste Honorine;;78700;France
email;internet:hubert.loewenguth@thales-bm.com
title:Software Engineer
tel;work:01-34-90-37-56
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------070203030109060505010200--
