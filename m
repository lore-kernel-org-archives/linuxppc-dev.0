Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail2.matrix-vision.com (mail2.matrix-vision.com
	[85.214.244.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "template", Issuer "template" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 62B0FB6FEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Apr 2011 07:12:00 +1000 (EST)
Date: Wed, 20 Apr 2011 23:11:54 +0200 (CEST)
From: "Schwarz,Andre" <andre.schwarz@matrix-vision.de>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Message-ID: <58915387.1151.1303333914478.JavaMail.open-xchange@proteus>
In-Reply-To: <20110420204441.GB29394@ovro.caltech.edu>
References: <211009162.1147.1303327260364.JavaMail.open-xchange@proteus>
	<20110420204441.GB29394@ovro.caltech.edu>
Subject: Re: tmpfs size restriction
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1150_1053748828.1303333914432"
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

------=_Part_1150_1053748828.1303333914432
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=C2=A0

"Ira W. Snyder" <iws@ovro.caltech.edu> hat am 20. April 2011 um 22:44
geschrieben:

> On Wed, Apr 20, 2011 at 09:21:00PM +0200, Schwarz,Andre wrote:
> > Hi,
> >
> > I'm facing an issue with tmpfs mounts on PowerPC (mpc83xx specifically)=
.
> >
> > After "mount -t tmpfs tmpfs /tmp -o size=3D16m" I can fill the machine'=
s mem
> > (512MiB) until oom becomes active.
> >
> > I can't see this on any other machine (x86/ARM) I have access to.
> > There's always a "no space left on device" message as soon as size spec=
ified
> > is
> > reached ...
> >
> > kernel versions available are v2.6.26.27 and v2.6.34.7 showing the same
> > behaviour.
> >
> > I'd expect the kernel to limit available tmpfs size to 50% of physical
> > memory
> > anyway.
> >
> > Any ideas what might be wrong ?
> >
>
> For what it is worth, I tried this on an 8349EA board, using 2.6.38rc8.
> It behaved exactly as I would expect. A short log is below. Maybe your
> mount command parses options differently on the powerpc machine?=C2=A0
even with incorrect/missing mount options the kernel should limit the size
to 50% phys mem ... at least according to doc/tmpfs.txt=C2=A0
=C2=A0

> Try it with the mount options before the mount points?=C2=A0
no effect.
=C2=A0

>
> iws@carmaboard7 ~ $ mkdir mnt
> mkdir: cannot create directory `mnt': File exists
> iws@carmaboard7 ~ $ ls mnt/
> iws@carmaboard7 ~ $ sudo mount -t tmpfs -o size=3D16m,users none mnt
> iws@carmaboard7 ~ $ ls mnt/
> iws@carmaboard7 ~ $ mount | grep mnt
> none on /home/iws/mnt type tmpfs (rw,nosuid,nodev,noexec,relatime,size=3D=
16384k)
> iws@carmaboard7 ~ $ cd ^C
> iws@carmaboard7 ~ $ dd if=3D/dev/zero of=3Dmnt/file.bin bs=3D1M count=3D1=
8
> dd: writing `mnt/file.bin': No space left on device
> 16+0 records in
> 15+0 records out
> 16760832 bytes (17 MB) copied, 0.313836 s, 53.4 MB/s
> iws@carmaboard7 ~ $ du -b mnt/file.bin
> 16760832=C2=A0 =C2=A0 =C2=A0 =C2=A0 mnt/file.bin
> iws@carmaboard7 ~ $ df -h mnt
> Filesystem=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Size=C2=A0 Used Avail=
 Use% Mounted on
> none=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
16M=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0-=C2=A0 /home/iws=
/mnt
> iws@carmaboard7 ~ $ uname -a
> Linux carmaboard7.correlator.pvt 2.6.38-rc8-00028-g24d6894 #1 Tue Mar 8
> 09:48:15 PST 2011 ppc e300c1 GNU/Linux
> iws@carmaboard7 ~ $ cat /proc/cpuinfo
> processor=C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
> cpu=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: e300c1
> clock=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 533.333328MHz
> revision=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 3.1 (pvr 8083 0031)
> bogomips=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 133.29
> timebase=C2=A0 =C2=A0 =C2=A0 =C2=A0 : 66646782
> platform=C2=A0 =C2=A0 =C2=A0 =C2=A0 : MPC834x MDS
> model=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: CARMA
> Memory=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 256 MB=C2=A0
yes - this is the expected behaviour I can see on all systems ... except mi=
ne
:-(=C2=A0
=C2=A0

> > Hope it helps,=C2=A0
no - but thank you for trying.=C2=A0
=C2=A0

Cheers,Andr=C3=A9=C2=A0
=0AMATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler=0ARegistergerich=
t: Amtsgericht Stuttgart, HRB 271090=0AGeschaeftsfuehrer: Gerhard Thullner, =
Werner Armingeon, Uwe Furtner=0A

------=_Part_1150_1053748828.1303333914432
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
    <title></title>
  </head>

  <body>
    <p style="margin: 0px;"><span>&#160;</span></p>

    <div style="margin: 5px 0px 5px 0px;">
      &quot;Ira W. Snyder&quot; &lt;iws@ovro.caltech.edu&gt; hat am 20. April 2011 um 22:44 geschrieben:<br/>
      <br/>
      &gt; On Wed, Apr 20, 2011 at 09:21:00PM +0200, Schwarz,Andre wrote:<br/>
      &gt; &gt; Hi,<br/>
      &gt; &gt;<br/>
      &gt; &gt; I&#39;m facing an issue with tmpfs mounts on PowerPC (mpc83xx specifically).<br/>
      &gt; &gt;<br/>
      &gt; &gt; After &quot;mount -t tmpfs tmpfs /tmp -o size=16m&quot; I can fill the machine&#39;s mem<br/>
      &gt; &gt; (512MiB) until oom becomes active.<br/>
      &gt; &gt;<br/>
      &gt; &gt; I can&#39;t see this on any other machine (x86/ARM) I have access to.<br/>
      &gt; &gt; There&#39;s always a &quot;no space left on device&quot; message as soon as size specified is<br/>
      &gt; &gt; reached ...<br/>
      &gt; &gt;<br/>
      &gt; &gt; kernel versions available are v2.6.26.27 and v2.6.34.7 showing the same<br/>
      &gt; &gt; behaviour.<br/>
      &gt; &gt;<br/>
      &gt; &gt; I&#39;d expect the kernel to limit available tmpfs size to 50% of physical memory<br/>
      &gt; &gt; anyway.<br/>
      &gt; &gt;<br/>
      &gt; &gt; Any ideas what might be wrong ?<br/>
      &gt; &gt;<br/>
      &gt;<br/>
      &gt; For what it is worth, I tried this on an 8349EA board, using 2.6.38rc8.<br/>
      &gt; It behaved exactly as I would expect. A short log is below. Maybe your<br/>
      &gt; mount command parses options differently on the powerpc machine?
    </div>

    <p style="margin: 0px;">&#160;</p>

    <p style="margin: 0px;">even with incorrect/missing mount options the kernel should limit the size</p>

    <p style="margin: 0px;">to 50% phys mem ... at least according to doc/tmpfs.txt&#160;</p>

    <p style="margin: 0px;">&#160;</p>

    <div style="margin: 5px 0px 5px 0px;">
      &gt; Try it with the mount options before the mount points?
    </div>

    <p style="margin: 0px;">&#160;</p>

    <p style="margin: 0px;">no effect.</p>

    <p style="margin: 0px;">&#160;</p>

    <div style="margin: 5px 0px 5px 0px;">
      &gt;<br/>
      &gt; iws@carmaboard7 ~ $ mkdir mnt<br/>
      &gt; mkdir: cannot create directory `mnt&#39;: File exists<br/>
      &gt; iws@carmaboard7 ~ $ ls mnt/<br/>
      &gt; iws@carmaboard7 ~ $ sudo mount -t tmpfs -o size=16m,users none mnt<br/>
      &gt; iws@carmaboard7 ~ $ ls mnt/<br/>
      &gt; iws@carmaboard7 ~ $ mount | grep mnt<br/>
      &gt; none on /home/iws/mnt type tmpfs (rw,nosuid,nodev,noexec,relatime,size=16384k)<br/>
      &gt; iws@carmaboard7 ~ $ cd ^C<br/>
      &gt; iws@carmaboard7 ~ $ dd if=/dev/zero of=mnt/file.bin bs=1M count=18<br/>
      &gt; dd: writing `mnt/file.bin&#39;: No space left on device<br/>
      &gt; 16+0 records in<br/>
      &gt; 15+0 records out<br/>
      &gt; 16760832 bytes (17 MB) copied, 0.313836 s, 53.4 MB/s<br/>
      &gt; iws@carmaboard7 ~ $ du -b mnt/file.bin<br/>
      &gt; 16760832&#160; &#160; &#160; &#160; mnt/file.bin<br/>
      &gt; iws@carmaboard7 ~ $ df -h mnt<br/>
      &gt; Filesystem&#160; &#160; &#160; &#160; &#160; &#160; Size&#160; Used Avail Use% Mounted on<br/>
      &gt; none&#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;16M&#160; &#160; &#160;-&#160; &#160; &#160;-&#160; &#160;-&#160; /home/iws/mnt<br/>
      &gt; iws@carmaboard7 ~ $ uname -a<br/>
      &gt; Linux carmaboard7.correlator.pvt 2.6.38-rc8-00028-g24d6894 #1 Tue Mar 8 09:48:15 PST 2011 ppc e300c1 GNU/Linux<br/>
      &gt; iws@carmaboard7 ~ $ cat /proc/cpuinfo<br/>
      &gt; processor&#160; &#160; &#160; &#160;: 0<br/>
      &gt; cpu&#160; &#160; &#160; &#160; &#160; &#160; &#160;: e300c1<br/>
      &gt; clock&#160; &#160; &#160; &#160; &#160; &#160;: 533.333328MHz<br/>
      &gt; revision&#160; &#160; &#160; &#160; : 3.1 (pvr 8083 0031)<br/>
      &gt; bogomips&#160; &#160; &#160; &#160; : 133.29<br/>
      &gt; timebase&#160; &#160; &#160; &#160; : 66646782<br/>
      &gt; platform&#160; &#160; &#160; &#160; : MPC834x MDS<br/>
      &gt; model&#160; &#160; &#160; &#160; &#160; &#160;: CARMA<br/>
      &gt; Memory&#160; &#160; &#160; &#160; &#160; : 256 MB
    </div>

    <p style="margin: 0px;">&#160;</p>

    <p style="margin: 0px;">yes - this is the expected behaviour I can see on all systems ... except mine :-(&#160;</p>

    <p style="margin: 0px;">&#160;</p>

    <div style="margin: 5px 0px 5px 0px;">
      &gt; &gt; Hope it helps,
    </div>

    <p style="margin: 0px;">&#160;</p>

    <p style="margin: 0px;">no - but thank you for trying.&#160;</p>

    <p style="margin: 0px;">&#160;</p>

    <div style="margin: 5px 0px 5px 0px;">
      Cheers,
    </div>

    <p style="margin: 0px;">Andr&#233;&#160;</p>
  
<br>

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<br>
</body>
</html>
------=_Part_1150_1053748828.1303333914432--
