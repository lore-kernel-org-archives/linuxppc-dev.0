Return-Path: <baykelper@yahoo.com>
Received: from web56208.mail.re3.yahoo.com (web56208.mail.re3.yahoo.com
	[216.252.110.217]) by ozlabs.org (Postfix) with SMTP id C80C1DDF26
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 18:32:45 +1100 (EST)
Message-ID: <710103.68816.qm@web56208.mail.re3.yahoo.com>
Date: Tue, 17 Feb 2009 23:32:43 -0800 (PST)
From: gt bradley <baykelper@yahoo.com>
Subject: Re: nfs booting PS3, mount failed. (Geoff Levand)
To: linuxppc-dev@ozlabs.org
In-Reply-To: <mailman.0.1234918803.22420.linuxppc-dev@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-707730600-1234942363=:68816"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--0-707730600-1234942363=:68816
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable



--- On Tue, 2/17/09, linuxppc-dev-request@ozlabs.org <linuxppc-dev-request@=
ozlabs.org> wrote:
From: linuxppc-dev-request@ozlabs.org <linuxppc-dev-request@ozlabs.org>
Subject: Linuxppc-dev Digest, Vol 54, Issue 101
To: linuxppc-dev@ozlabs.org
Date: Tuesday, February 17, 2009, 5:00 PM

Send Linuxppc-dev mailing list submissions to
=09linuxppc-dev@ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
=09https://ozlabs.org/mailman/listinfo/linuxppc-dev
or, via email, send a message with subject or body 'help' to
=09linuxppc-dev-request@ozlabs.org

You can reach the person managing the list at
=09linuxppc-dev-owner@ozlabs.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linuxppc-dev digest..."
Today's Topics:

   1. NFS-boot on PS3, kboot can't mount nfs-dir.s (gt bradley)
   2. Re: nfs booting PS3, mount failed. (Geoff Levand)
   3. Re: nfs booting PS3, mount failed. (Geoff Levand)
I'm trying to set up my PS3 to netboot (with an nfsroot).

I'm using instructions at http://www.kernel.org/pub/linux/kernel/people/geo=
ff/cell/ps3-howto/ps3-nfs-root-howto.txt

I've
passed section 3 (using tftp) to verify network /dhcp etc.=A0=A0 (i.e. I'm
able to tftp-get a file to ps3 from kboot's ash shell (busybox).

i'm trying to mount the nfs server as per section 4. with
 ~# mount -t nfs -o nolock 192.168.99.1:/target /mnt/remote

I get the following error message:
  mount: mounting 192.168.99.1:/target on /mnt/remote failed

if I boot the PS3 from the HD, then I am able to mount the nfs directory.
Using wireshark, I can see the initial dhcp traffic, (and when present the =
tftp traffic).
the mount command doesn't open a network connection to the server,=20
So I have pretty much ruled out server
 configuration.

running "strings" on the decompressed kboot image yeilds serveral nfs symbo=
ls, so it=20
appears to still support nfs mounting.  (using version kboot-20080609.bld f=
rom geoff's dir at kernel.org)
I have tried googling, and searching the various mailing lists, but am stuc=
k.

any help would be
 appreciated
GT



      On 02/17/2009 04:20 PM, Geoff Levand wrote:

> Another thing to try is to use a 'rescue' disk/mode to copy the
files.
> Most distros have them.  Fedora has a rescue mode in their installer:
>=20
> =20
http://download.fedora.redhat.com/pub/fedora/linux/releases/10/Fedora/ppc/i=
so/Fedora-10-ppc-netinst.iso
>=20
> Just select 'rescue' instead of 'install', or you can add
> these to the boot options: 'text rescue video=3D720p'.

I forgot to mention an important point when using a rescue disk.
Most will mount all the runtime directories like /sys, /dev, /proc,
etc. onto the HD file system.  Those directories should not be
mounted the when you make the HD root FS copy.

Either choose the rescue option to not mount the HD file system,
and mount it yourself later, or unmount all those directories.
Just use the 'mount' command to see what has been mounted on the
HD's root FS.

-Geoff


On 02/16/2009 09:22 PM, gt bradley wrote:
> I'm trying to set up my PS3 to netboot (with an nfsroot).
>=20
> I'm using instructions at
>
http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-howto/ps3-nfs-=
root-howto.txt
>=20
> I've passed section 3 (using tftp) to verify network /dhcp etc. =20
(i.e.
> I'm able to tftp-get a file to ps3 from kboot's ash shell
(busybox).
>=20
> i'm trying to mount the nfs server as per section 4. with
>=20
>  ~# mount -t nfs -o nolock 192.168.99.1:/target /mnt/remote
>=20
> I get the following error message:
>   mount: mounting 192.168.99.1:/target on /mnt/remote failed
>=20
> if I boot the PS3 from the HD, then I am able to mount the nfs directory.
> Using wireshark, I can see the initial dhcp traffic, (and when present th=
e
tftp traffic).
> the mount command doesn't open a network connection to the server,=20
> So I have pretty much ruled out server
>  configuration.
>=20
> running "strings" on the decompressed kboot image yeilds
serveral nfs symbols, so it=20
> appears to still support nfs mounting.  (using version kboot-20080609.bld
from geoff's dir at kernel.org)

I have sometimes seen nfs problems with kboot.  You could you
try petitboot.  Get the latest 'experimental' one from here:

  http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-petitboot/

Another thing to try is to use a 'rescue' disk/mode to copy the files.
Most distros have them.  Fedora has a rescue mode in their installer:

=20
http://download.fedora.redhat.com/pub/fedora/linux/releases/10/Fedora/ppc/i=
so/Fedora-10-ppc-netinst.iso

Just select 'rescue' instead of 'install', or you can add
these to the boot options: 'text rescue video=3D720p'.

You don't need kboot/petitboot to do nfs.  To load the kernel
they just need to do tftp.

-Geoff
 =20


I'll try this this week-end, and let you know how it goes,=20
 Thank-you for the quick response.
GT=0A=0A=0A      
--0-707730600-1234942363=:68816
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><br><br>--- On <b>Tue, 2/17/09, linuxppc-dev-=
request@ozlabs.org <i>&lt;linuxppc-dev-request@ozlabs.org&gt;</i></b> wrote=
:<br><blockquote style=3D"border-left: 2px solid rgb(16, 16, 255); margin-l=
eft: 5px; padding-left: 5px;">From: linuxppc-dev-request@ozlabs.org &lt;lin=
uxppc-dev-request@ozlabs.org&gt;<br>Subject: Linuxppc-dev Digest, Vol 54, I=
ssue 101<br>To: linuxppc-dev@ozlabs.org<br>Date: Tuesday, February 17, 2009=
, 5:00 PM<br><br><pre>Send Linuxppc-dev mailing list submissions to<br>=09l=
inuxppc-dev@ozlabs.org<br><br>To subscribe or unsubscribe via the World Wid=
e Web, visit<br>=09https://ozlabs.org/mailman/listinfo/linuxppc-dev<br>or, =
via email, send a message with subject or body 'help' to<br>=09linuxppc-dev=
-request@ozlabs.org<br><br>You can reach the person managing the list at<br=
>=09linuxppc-dev-owner@ozlabs.org<br><br>When replying, please edit your Su=
bject line so
 it is more specific<br>than "Re: Contents of Linuxppc-dev digest..."<br></=
pre><pre>Today's Topics:<br><br>   1. NFS-boot on PS3, kboot can't mount nf=
s-dir.s (gt bradley)<br>   2. Re: nfs booting PS3, mount failed. (Geoff Lev=
and)<br>   3. Re: nfs booting PS3, mount failed. (Geoff Levand)<br></pre><d=
iv id=3D"yiv449585260"><table border=3D"0" cellpadding=3D"0" cellspacing=3D=
"0"><tbody><tr><td style=3D"font-family: inherit; font-style: inherit; font=
-variant: inherit; font-weight: inherit; font-size: inherit; line-height: i=
nherit; font-size-adjust: inherit; font-stretch: inherit; -x-system-font: n=
one;" valign=3D"top">I'm trying to set up my PS3 to netboot (with an nfsroo=
t).<br><br>I'm using instructions at http://www.kernel.org/pub/linux/kernel=
/people/geoff/cell/ps3-howto/ps3-nfs-root-howto.txt<br><br>I've
passed section 3 (using tftp) to verify network /dhcp etc.&nbsp;&nbsp; (i.e=
. I'm
able to tftp-get a file to ps3 from kboot's ash shell (busybox).<br><br>i'm=
 trying to mount the nfs server as per section 4. with<br><pre> ~# mount -t=
 nfs -o nolock 192.168.99.1:/target /mnt/remote<br><br>I get the following =
error message:<br>  mount: mounting 192.168.99.1:/target on /mnt/remote fai=
led<br><br>if I boot the PS3 from the HD, then I am able to mount the nfs d=
irectory.<br>Using wireshark, I can see the initial dhcp traffic, (and when=
 present the tftp traffic).<br>the mount command doesn't open a network con=
nection to the server, <br>So I have pretty much ruled out server<br> confi=
guration.<br><br>running "strings" on the decompressed kboot image yeilds s=
erveral nfs symbols, so it <br>appears to still support nfs mounting.  (usi=
ng version kboot-20080609.bld from geoff's dir at kernel.org)<br></pre>I ha=
ve tried googling, and searching the various mailing lists, but am stuck.<s=
pan style=3D"font-family: monospace;"><br><br>any help would be
 appreciated<br>GT<br></span></td></tr></tbody></table><br>

      </div><pre>On 02/17/2009 04:20 PM, Geoff Levand wrote:<br><br>&gt; An=
other thing to try is to use a 'rescue' disk/mode to copy the<br>files.<br>=
&gt; Most distros have them.  Fedora has a rescue mode in their installer:<=
br>&gt; <br>&gt;  <br>http://download.fedora.redhat.com/pub/fedora/linux/re=
leases/10/Fedora/ppc/iso/Fedora-10-ppc-netinst.iso<br>&gt; <br>&gt; Just se=
lect 'rescue' instead of 'install', or you can add<br>&gt; these to the boo=
t options: 'text rescue video=3D720p'.<br><br>I forgot to mention an import=
ant point when using a rescue disk.<br>Most will mount all the runtime dire=
ctories like /sys, /dev, /proc,<br>etc. onto the HD file system.  Those dir=
ectories should not be<br>mounted the when you make the HD root FS copy.<br=
><br>Either choose the rescue option to not mount the HD file system,<br>an=
d mount it yourself later, or unmount all those directories.<br>Just use th=
e 'mount' command to see what has been mounted on the<br>HD's root
 FS.<br><br>-Geoff<br><br><br></pre><pre>On 02/16/2009 09:22 PM, gt bradley=
 wrote:<br>&gt; I'm trying to set up my PS3 to netboot (with an nfsroot).<b=
r>&gt; <br>&gt; I'm using instructions at<br>&gt;<br>http://www.kernel.org/=
pub/linux/kernel/people/geoff/cell/ps3-howto/ps3-nfs-root-howto.txt<br>&gt;=
 <br>&gt; I've passed section 3 (using tftp) to verify network /dhcp etc.  =
<br>(i.e.<br>&gt; I'm able to tftp-get a file to ps3 from kboot's ash shell=
<br>(busybox).<br>&gt; <br>&gt; i'm trying to mount the nfs server as per s=
ection 4. with<br>&gt; <br>&gt;  ~# mount -t nfs -o nolock 192.168.99.1:/ta=
rget /mnt/remote<br>&gt; <br>&gt; I get the following error message:<br>&gt=
;   mount: mounting 192.168.99.1:/target on /mnt/remote failed<br>&gt; <br>=
&gt; if I boot the PS3 from the HD, then I am able to mount the nfs directo=
ry.<br>&gt; Using wireshark, I can see the initial dhcp traffic, (and when =
present the<br>tftp traffic).<br>&gt; the mount command doesn't open
 a network connection to the server, <br>&gt; So I have pretty much ruled o=
ut server<br>&gt;  configuration.<br>&gt; <br>&gt; running "strings" on the=
 decompressed kboot image yeilds<br>serveral nfs symbols, so it <br>&gt; ap=
pears to still support nfs mounting.  (using version kboot-20080609.bld<br>=
from geoff's dir at kernel.org)<br><br>I have sometimes seen nfs problems w=
ith kboot.  You could you<br>try petitboot.  Get the latest 'experimental' =
one from here:<br><br>  http://www.kernel.org/pub/linux/kernel/people/geoff=
/cell/ps3-petitboot/<br><br>Another thing to try is to use a 'rescue' disk/=
mode to copy the files.<br>Most distros have them.  Fedora has a rescue mod=
e in their installer:<br><br> <br>http://download.fedora.redhat.com/pub/fed=
ora/linux/releases/10/Fedora/ppc/iso/Fedora-10-ppc-netinst.iso<br><br>Just =
select 'rescue' instead of 'install', or you can add<br>these to the boot o=
ptions: 'text rescue video=3D720p'.<br><br>You don't need
 kboot/petitboot to do nfs.  To load the kernel<br>they just need to do tft=
p.<br><br>-Geoff<br>  <br><br><br>I'll try this this week-end, and let you =
know how it goes, <br> Thank-you for the quick response.<br>GT</pre></block=
quote></td></tr></table><br>=0A=0A=0A=0A      
--0-707730600-1234942363=:68816--
