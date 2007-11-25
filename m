Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound1-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9D7E0DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Nov 2007 10:58:57 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C82FBF.220D29B4"
Subject: RE: Xilinx devicetrees
Date: Sun, 25 Nov 2007 15:58:53 -0800
References: <47480CF0.7090105@dlasys.net>	<fa686aa40711240912r192aba72o2cbdb798370e7b7c@mail.gmail.com>	<47493D4F.4070605@dlasys.net><fa686aa40711251421q38f53ee3hb2a308cc5f93183f@mail.gmail.com>
	<4749FD5E.7000408@dlasys.net>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	"linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Message-Id: <20071125235855.95B9999804D@mail138-cpk.bigfish.com>
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

------_=_NextPart_001_01C82FBF.220D29B4
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I understand that you're trying to be somewhat of a devil's advocate =
here, but (as I mentioned in my other email), alot of these are issues =
we're attempting to tackle.
More comments below.

-----Original Message-----
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of David H. Lynch Jr.
Sent: Sun 11/25/2007 2:55 PM
To: Grant Likely; linuxppc-embedded
Subject: Re: Xilinx devicetrees
=20
Grant Likely wrote:
>    I am not expert on this, but at Pico we already store our boot
> monitor in the .bit files in BRAM.
>     But that is not free.  It is one of the reasons we do not use
> u-boot. Our boot monitor must fit into 16K of BRAM.
>     Must be able to perform selftests on critical hardware, support a
> flash file system, load bit files from flash to the FGA, load and
> exectute elf files, allow a small set of user commands, and handle
> hosted vs. standalone operation.
>     And aparently extract the devicetree from a bit file and pass it =
to
> a linux kernel.

Once you can load a bitstream from flash, loading the device tree from =
flash
should be practically free.  In any event, why do you do this rather =
than just run out of the flash (or a ram copy of the flash?)

>     In static or fairly static hardware, that's fine. Even in somewhat
> dynamic hardware with large quantities of startup resources - like a =
PC.
>     But in highly dynamic hardware with fairly limited resources it
> starts to become an issue.

As Grant says, the dynamic detection doesn't have to be done in the boot =
loader, it could be done in the platform code.  You can largely ignore =
the device trees, or always boot with a core device tree and figure it =
all out later (perhaps using version registers).  I anticipate that the =
'standard flow' will have standard platform code for any board that uses =
a complete device tree.  If you have the need to do something =
extraordinary, then you should feel free to hack away...  However, It =
doesn't seem to me to be really necessary in your case, assuming that =
the device tree is packaged (somehow, TBD) along with the bitstream.

>> No, unfortunately they don't deal with the problem you're facing
>> (which I'm facing also).  But it will be solved if we figure out a
>> sane way to bind the device tree up with the FPGA bitstream without
>> consuming FPGA resources.
>>  =20
>    Note to Xilinx:
>
>       There MUST be some way of binding a device description to a bit =
file.
>
>    neither building it into the FPGA fabric nor appending it to the =
end
> of the bit file are perfect solutions,
>    The former is more powerfull and flexible but wastes precious
> resources. The later is more complex and puts more burdens on
>    software developers, and may be completely unfeasible in some
> environments - not mine fortunately.

I don't understand the 'burden on software developers'.  The code to do =
this will just be standard code.  The worst that one can say is:
1) I need several KB additional non volatile storage.  Given the size of =
the FPGA bitstream, this can't be a huge constraint.
2) I can't use compile time optimization based on xparameters as easily. =
 Anyone want to implement the alternatives mechanism on ppc and =
microblaze?
3) Some additional boot time.  However, again, this seems marginal.

>    Regardless, something must be done. An odd collection of devicetree
> files co-mingled with a collection of bit files, is little better than
> xparameter files all over the place.

Certainly..  But in a sense, these are all intermediate files on the =
path to the image on the board.  That (and how it is interpreted by the =
platform code) should be generated in a consistent fashion by EDK.  See =
my other email for some of the possibilities.  Are there specific =
reasons why you think those proposals are inadequate?  Now is the time =
when we can take criticism, with the goal towards making a good end =
solution.

>    And once again a plea to ALWAYS make version/capabilities registers
> atleast an optional part of every design.
>    Embeddeding a device tree into a design might be fairly expensive. =
a
> pair of read only 32 bit registers is damn near free - basically the
> FPGA equivalent of atmost 64 diodes or resistors.

Actually, device trees actually seem to be cheaper (in the whole system =
sense) than such registers.  Unless there is something I don't =
understand?

Steve

------_=_NextPart_001_01C82FBF.220D29B4
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Xilinx devicetrees</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>I understand that you're trying to be somewhat of a =
devil's advocate here, but (as I mentioned in my other email), alot of =
these are issues we're attempting to tackle.<BR>
More comments below.<BR>
<BR>
-----Original Message-----<BR>
From: linuxppc-embedded-bounces+stephen=3Dneuendorffer.name@ozlabs.org =
on behalf of David H. Lynch Jr.<BR>
Sent: Sun 11/25/2007 2:55 PM<BR>
To: Grant Likely; linuxppc-embedded<BR>
Subject: Re: Xilinx devicetrees<BR>
<BR>
Grant Likely wrote:<BR>
&gt;&nbsp;&nbsp;&nbsp; I am not expert on this, but at Pico we already =
store our boot<BR>
&gt; monitor in the .bit files in BRAM.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; But that is not free.&nbsp; It is one of =
the reasons we do not use<BR>
&gt; u-boot. Our boot monitor must fit into 16K of BRAM.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Must be able to perform selftests on =
critical hardware, support a<BR>
&gt; flash file system, load bit files from flash to the FGA, load =
and<BR>
&gt; exectute elf files, allow a small set of user commands, and =
handle<BR>
&gt; hosted vs. standalone operation.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; And aparently extract the devicetree from a =
bit file and pass it to<BR>
&gt; a linux kernel.<BR>
<BR>
Once you can load a bitstream from flash, loading the device tree from =
flash<BR>
should be practically free.&nbsp; In any event, why do you do this =
rather than just run out of the flash (or a ram copy of the flash?)<BR>
<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; In static or fairly static hardware, that's =
fine. Even in somewhat<BR>
&gt; dynamic hardware with large quantities of startup resources - like =
a PC.<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; But in highly dynamic hardware with fairly =
limited resources it<BR>
&gt; starts to become an issue.<BR>
<BR>
As Grant says, the dynamic detection doesn't have to be done in the boot =
loader, it could be done in the platform code.&nbsp; You can largely =
ignore the device trees, or always boot with a core device tree and =
figure it all out later (perhaps using version registers).&nbsp; I =
anticipate that the 'standard flow' will have standard platform code for =
any board that uses a complete device tree.&nbsp; If you have the need =
to do something extraordinary, then you should feel free to hack =
away...&nbsp; However, It doesn't seem to me to be really necessary in =
your case, assuming that the device tree is packaged (somehow, TBD) =
along with the bitstream.<BR>
<BR>
&gt;&gt; No, unfortunately they don't deal with the problem you're =
facing<BR>
&gt;&gt; (which I'm facing also).&nbsp; But it will be solved if we =
figure out a<BR>
&gt;&gt; sane way to bind the device tree up with the FPGA bitstream =
without<BR>
&gt;&gt; consuming FPGA resources.<BR>
&gt;&gt;&nbsp;&nbsp;<BR>
&gt;&nbsp;&nbsp;&nbsp; Note to Xilinx:<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; There MUST be some way of =
binding a device description to a bit file.<BR>
&gt;<BR>
&gt;&nbsp;&nbsp;&nbsp; neither building it into the FPGA fabric nor =
appending it to the end<BR>
&gt; of the bit file are perfect solutions,<BR>
&gt;&nbsp;&nbsp;&nbsp; The former is more powerfull and flexible but =
wastes precious<BR>
&gt; resources. The later is more complex and puts more burdens on<BR>
&gt;&nbsp;&nbsp;&nbsp; software developers, and may be completely =
unfeasible in some<BR>
&gt; environments - not mine fortunately.<BR>
<BR>
I don't understand the 'burden on software developers'.&nbsp; The code =
to do this will just be standard code.&nbsp; The worst that one can say =
is:<BR>
1) I need several KB additional non volatile storage.&nbsp; Given the =
size of the FPGA bitstream, this can't be a huge constraint.<BR>
2) I can't use compile time optimization based on xparameters as =
easily.&nbsp; Anyone want to implement the alternatives mechanism on ppc =
and microblaze?<BR>
3) Some additional boot time.&nbsp; However, again, this seems =
marginal.<BR>
<BR>
&gt;&nbsp;&nbsp;&nbsp; Regardless, something must be done. An odd =
collection of devicetree<BR>
&gt; files co-mingled with a collection of bit files, is little better =
than<BR>
&gt; xparameter files all over the place.<BR>
<BR>
Certainly..&nbsp; But in a sense, these are all intermediate files on =
the path to the image on the board.&nbsp; That (and how it is =
interpreted by the platform code) should be generated in a consistent =
fashion by EDK.&nbsp; See my other email for some of the =
possibilities.&nbsp; Are there specific reasons why you think those =
proposals are inadequate?&nbsp; Now is the time when we can take =
criticism, with the goal towards making a good end solution.<BR>
<BR>
&gt;&nbsp;&nbsp;&nbsp; And once again a plea to ALWAYS make =
version/capabilities registers<BR>
&gt; atleast an optional part of every design.<BR>
&gt;&nbsp;&nbsp;&nbsp; Embeddeding a device tree into a design might be =
fairly expensive. a<BR>
&gt; pair of read only 32 bit registers is damn near free - basically =
the<BR>
&gt; FPGA equivalent of atmost 64 diodes or resistors.<BR>
<BR>
Actually, device trees actually seem to be cheaper (in the whole system =
sense) than such registers.&nbsp; Unless there is something I don't =
understand?<BR>
<BR>
Steve<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C82FBF.220D29B4--
