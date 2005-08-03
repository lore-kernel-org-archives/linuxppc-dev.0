Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 2E57B67EAD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Aug 2005 00:36:00 +1000 (EST)
Message-ID: <42F0D64F.80600@ru.mvista.com>
Date: Wed, 03 Aug 2005 18:35:59 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
References: <8E342283C2100540AAC5D103097054776F8533@rcexc.racoms.loc>
In-Reply-To: <8E342283C2100540AAC5D103097054776F8533@rcexc.racoms.loc>
Content-Type: multipart/alternative;
	boundary="------------010904070501010007050402"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885ADS and 2.6.13-rc5 - nogo ?
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
--------------010904070501010007050402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Schaefer-Hutter, Peter wrote:

>Hello,
>
>  
>
>>From: Vitaly Bordug [mailto:vbordug@ru.mvista.com] 
>>    
>>
>
>  
>
>>The board does not hang - there's somithing with 
>>console since you don't see anything.  Try to change 
>>BCSR_ADDR from 0xf4500000 to 0xf80...0 - the newer 
>>version of the boards may have this changed.
>>    
>>
>
>Hrm... arc/ppc/mpc885ads.h already reads
>
>  /* U-Boot maps BCSR to 0xff080000 */
>  #define BCSR_ADDR   ((uint)0xff080000)
>
>And that's the same setting that my 2.4-Kernel
>uses, so it should work with 0xff080000.
>
>However, BCSR_SIZE looks suspicious in this header:
>
>  #define BCSR_SIZE   ((uint)32)
>
>Shouldn't that read:
>
>  #define BCSR_SIZE   ((uint)32 * 1024)
>
>??!?
>
>Regards,
>
>  Peter
>
>  
>
<quotation> (This is from 8272 User Guide, but 885 I guess is the same 
in this part)

> Most of the hardware options on the MPC8272ADS are controlled or 
> monitored by the
> BCSR, which is a 32 bit wide read / write register file. The BCSR is 
> accessed via the
> MPC8272s' memory controller (see Table 5-5) and in fact includes 8 
> registers: BCSR0 to
> BCSR7. Since the minimum block size for a CS region is 32KBytes and 
> only A(27:29)
> lines are decoded by the BCSR for register selection, BCSR0 - BCSR7 
> are duplicated inside
> that region.

<quotation\>

-- 
Sincerely, 
Vitaly


--------------010904070501010007050402
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Schaefer-Hutter, Peter wrote:
<blockquote
 cite="mid8E342283C2100540AAC5D103097054776F8533@rcexc.racoms.loc"
 type="cite">
  <pre wrap="">Hello,

  </pre>
  <blockquote type="cite">
    <pre wrap="">From: Vitaly Bordug [<a class="moz-txt-link-freetext" href="mailto:vbordug@ru.mvista.com">mailto:vbordug@ru.mvista.com</a>] 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
  <blockquote type="cite">
    <pre wrap="">The board does not hang - there's somithing with 
console since you don't see anything.  Try to change 
BCSR_ADDR from 0xf4500000 to 0xf80...0 - the newer 
version of the boards may have this changed.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Hrm... arc/ppc/mpc885ads.h already reads

  /* U-Boot maps BCSR to 0xff080000 */
  #define BCSR_ADDR   ((uint)0xff080000)

And that's the same setting that my 2.4-Kernel
uses, so it should work with 0xff080000.

However, BCSR_SIZE looks suspicious in this header:

  #define BCSR_SIZE   ((uint)32)

Shouldn't that read:

  #define BCSR_SIZE   ((uint)32 * 1024)

??!?

Regards,

  Peter

  </pre>
</blockquote>
&lt;quotation&gt; (This is from 8272 User Guide, but 885 I guess is the
same in this part)<br>
<blockquote
 cite="mid8E342283C2100540AAC5D103097054776F8533@rcexc.racoms.loc"
 type="cite">Most of the hardware options on the MPC8272ADS are
controlled or monitored by the<br>
BCSR, which is a 32 bit wide read / write register file. The BCSR is
accessed via the<br>
MPC8272s&#8217; memory controller (see Table 5-5) and in fact includes 8
registers: BCSR0 to<br>
BCSR7. Since the minimum block size for a CS region is 32KBytes and
only A(27:29)<br>
lines are decoded by the BCSR for register selection, BCSR0 - BCSR7 are
duplicated inside<br>
that region.</blockquote>
&lt;quotation\&gt;<br>
<br>
<pre class="moz-signature" cols="72">-- 
Sincerely, 
Vitaly
</pre>
</body>
</html>

--------------010904070501010007050402--
