Return-Path: <stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8DA2F.BC0405AC"
Subject: RE: [PATCH] powerpc/bootwrapper: Add documentation of boot
	wrappertargets
Date: Sun, 29 Jun 2008 14:30:08 -0700
References: <20080625202104.30114.47902.stgit@trillian.secretlab.ca><20080626164842.1D3AB1358053@mail15-sin.bigfish.com><1214507238.7698.3.camel@weaponx><20080626201643.D01221788058@mail223-wa4.bigfish.com>
	<fa686aa40806272122g3f4148d3ua1e59df54709cc68@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20080629213315.485331AB8053@mail79-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.com, Scott Wood <scottwood@freescale.com>,
	paulus@samba.org, John Linn <linnj@xilinx.com>,
	petermendham@computing.dundee.ac.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------_=_NextPart_001_01C8DA2F.BC0405AC
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


simpleImage should also create an .elf (for xmd or systemAce loading)
If dtbImage and simpleImage could be merged, I'd be all for it...

At some point of course, I need to figure merge the Device Tree in BRAM cod=
e that I've been using, which would be a simpleImage which wouldn't need a =
device tree.  However, I don't see this happening before August.

Steve

-----Original Message-----
From: glikely@secretlab.ca on behalf of Grant Likely
Sent: Fri 6/27/2008 9:22 PM
To: Stephen Neuendorffer
Cc: Josh Boyer; John Linn; linuxppc-dev@ozlabs.com; paulus@samba.org; peter=
mendham@computing.dundee.ac.uk; Scott Wood; Geoff Levand
Subject: Re: [PATCH] powerpc/bootwrapper: Add documentation of boot wrapper=
targets
 =

On Thu, Jun 26, 2008 at 1:16 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> Forgive my ignorance here, but what specifically does this imply?  As
> far as I can tell, generally speaking, some of the board-specific
> information is passed into the boot wrapper, which then stuffs it into
> the device tree.

Yes, you are correct.  I'll fill out the documentation more here.

>> uImage is for device-tree aware U-Boot versions
>
> And this differs from above because it gets a device tree passed in,
> which uboot has already stuffed correctly.

Correct.

>> dtbImage is used for boards that can take an ELF zImage, but still
> need
>> a dtb provided.
>>
>> simpleImage, not sure here.
>
> So both of these are elfs...  but how do they differ?  Is it only in how
> the right head.s file gets picked up?

simpleImage is not an elf.  Its a raw position-independent binary
which can be loaded anywhere in RAM.

Some dtbImages are elfs; but there are a flat binaries.  The main
difference is that all simpleImages assume that firmware provides
nothing interesting; but the flat dtbImages have custom code for
extracting a little bit of data out of the boards firmware.

It's all a bit of a confusing mess.  It might be a good idea to rework
all the image names to stuff not so non-obvious, but I'm not sure the
best way to go about it.  There is a lot of historical stuff in there
where the various 'zImage.*' targets grew and morphed over time in
ways that are hard to follow.  It may make more sense to change the
flat-binary dtbImages to be simpleImages instead with overrides for
specific boards (just like is done for virtex405-*).  ps3 is the other
major user of dtbImage.  I created the whole dtbImage stuff in the
first place to eliminate overloaded makefile targets where some
zImage% target were providing a device tree and other zImage% targets
were not.  Splitting dtb-provided from dtb-not-provided targets
clarified the Makefile quite a bit.  dtbImage is not a fantastic name,
but I needed something different from zImage for images with an
embedded device tree.

Looking at the Makefile, dtbImage and simpleImage targets are
virtually identical.  Perhaps it would be best to merge the targets
and deal with all the differences in the wrapper script (with the
default to just use simpleboot.S as the init code).  Thoughts?

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.




This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


------_=_NextPart_001_01C8DA2F.BC0405AC
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7652.24"=
>
<TITLE>RE: [PATCH] powerpc/bootwrapper: Add documentation of boot wrapperta=
rgets</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>simpleImage should also create an .elf (for xmd or system=
Ace loading)<BR>
If dtbImage and simpleImage could be merged, I'd be all for it...<BR>
<BR>
At some point of course, I need to figure merge the Device Tree in BRAM cod=
e that I've been using, which would be a simpleImage which wouldn't need a =
device tree.&nbsp; However, I don't see this happening before August.<BR>
<BR>
Steve<BR>
<BR>
-----Original Message-----<BR>
From: glikely@secretlab.ca on behalf of Grant Likely<BR>
Sent: Fri 6/27/2008 9:22 PM<BR>
To: Stephen Neuendorffer<BR>
Cc: Josh Boyer; John Linn; linuxppc-dev@ozlabs.com; paulus@samba.org; peter=
mendham@computing.dundee.ac.uk; Scott Wood; Geoff Levand<BR>
Subject: Re: [PATCH] powerpc/bootwrapper: Add documentation of boot wrapper=
targets<BR>
<BR>
On Thu, Jun 26, 2008 at 1:16 PM, Stephen Neuendorffer<BR>
&lt;stephen.neuendorffer@xilinx.com&gt; wrote:<BR>
&gt; Forgive my ignorance here, but what specifically does this imply?&nbsp=
; As<BR>
&gt; far as I can tell, generally speaking, some of the board-specific<BR>
&gt; information is passed into the boot wrapper, which then stuffs it into=
<BR>
&gt; the device tree.<BR>
<BR>
Yes, you are correct.&nbsp; I'll fill out the documentation more here.<BR>
<BR>
&gt;&gt; uImage is for device-tree aware U-Boot versions<BR>
&gt;<BR>
&gt; And this differs from above because it gets a device tree passed in,<B=
R>
&gt; which uboot has already stuffed correctly.<BR>
<BR>
Correct.<BR>
<BR>
&gt;&gt; dtbImage is used for boards that can take an ELF zImage, but still=
<BR>
&gt; need<BR>
&gt;&gt; a dtb provided.<BR>
&gt;&gt;<BR>
&gt;&gt; simpleImage, not sure here.<BR>
&gt;<BR>
&gt; So both of these are elfs...&nbsp; but how do they differ?&nbsp; Is it=
 only in how<BR>
&gt; the right head.s file gets picked up?<BR>
<BR>
simpleImage is not an elf.&nbsp; Its a raw position-independent binary<BR>
which can be loaded anywhere in RAM.<BR>
<BR>
Some dtbImages are elfs; but there are a flat binaries.&nbsp; The main<BR>
difference is that all simpleImages assume that firmware provides<BR>
nothing interesting; but the flat dtbImages have custom code for<BR>
extracting a little bit of data out of the boards firmware.<BR>
<BR>
It's all a bit of a confusing mess.&nbsp; It might be a good idea to rework=
<BR>
all the image names to stuff not so non-obvious, but I'm not sure the<BR>
best way to go about it.&nbsp; There is a lot of historical stuff in there<=
BR>
where the various 'zImage.*' targets grew and morphed over time in<BR>
ways that are hard to follow.&nbsp; It may make more sense to change the<BR=
>
flat-binary dtbImages to be simpleImages instead with overrides for<BR>
specific boards (just like is done for virtex405-*).&nbsp; ps3 is the other=
<BR>
major user of dtbImage.&nbsp; I created the whole dtbImage stuff in the<BR>=

first place to eliminate overloaded makefile targets where some<BR>
zImage% target were providing a device tree and other zImage% targets<BR>
were not.&nbsp; Splitting dtb-provided from dtb-not-provided targets<BR>
clarified the Makefile quite a bit.&nbsp; dtbImage is not a fantastic name,=
<BR>
but I needed something different from zImage for images with an<BR>
embedded device tree.<BR>
<BR>
Looking at the Makefile, dtbImage and simpleImage targets are<BR>
virtually identical.&nbsp; Perhaps it would be best to merge the targets<BR=
>
and deal with all the differences in the wrapper script (with the<BR>
default to just use simpleboot.S as the init code).&nbsp; Thoughts?<BR>
<BR>
Cheers,<BR>
g.<BR>
<BR>
--<BR>
Grant Likely, B.Sc., P.Eng.<BR>
Secret Lab Technologies Ltd.<BR>
<BR>
<BR>
</FONT>
</P>

<br clear=3Dall> This email and any attachments are intended for the sole u=
se of the named recipient(s) and contain(s) confidential information that m=
ay be proprietary, privileged or copyrighted under applicable law. If you a=
re not the intended recipient, do not read, copy, or forward this email mes=
sage or any attachments. Delete this email message and any attachments imme=
diately.
</BODY>
</HTML>


------_=_NextPart_001_01C8DA2F.BC0405AC--
