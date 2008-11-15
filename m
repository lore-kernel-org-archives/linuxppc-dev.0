Return-Path: <cristian.axenie@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id BB03BDDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 22:15:10 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1462569fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 03:15:08 -0800 (PST)
Message-ID: <9c789a000811150315u3e390a49gf8fa16c16adfbf51@mail.gmail.com>
Date: Sat, 15 Nov 2008 13:15:07 +0200
From: "Cristian Axenie" <cristian.axenie@gmail.com>
To: "Nicholas Mc Guire" <hofrat@hofr.at>, linuxppc-embedded@ozlabs.org,
	"Joachim Foerster" <mls.JOFT@gmx.de>
Subject: Re: USB Flash rootfs prep!
In-Reply-To: <Pine.LNX.4.58.0811150138440.4494@vlab.hofr.at>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17152_3586432.1226747707870"
References: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
	<1226737139.17218.14.camel@md40100b.ft>
	<9c789a000811150112q3088a044ub8b38489b2119a60@mail.gmail.com>
	<9c789a000811150112i484baa39y846bbf38ed6e1bb8@mail.gmail.com>
	<Pine.LNX.4.58.0811150051230.4465@vlab.hofr.at>
	<9c789a000811150217o3c08e94ar3f99eda848822e62@mail.gmail.com>
	<Pine.LNX.4.58.0811150138440.4494@vlab.hofr.at>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_17152_3586432.1226747707870
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, Nov 15, 2008 at 12:40 PM, Nicholas Mc Guire <hofrat@hofr.at> wrote:

> > >
> > > did you check that it is actually a valid character device (c 5 1) ?
> > > it can easaly happend during copying of a tree into your image that
> > > they become regular files.
> > >
> > > hofrat
> > >
> > I think that you are right, butr how can I test this validity??
> >
> just check with ls -l that the device file is actually still a character
> device with the right major/minor number.
>
> crw--w--w-    1 root     tty        5,   1 Nov 13 22:18 /mnt/dev/console
>
> modes and date of course may be diferent.
>
> hofrat
>

I mount my ext2.img and run ls -l and I get

crw-r----- 1 root root   5,   1 2008-11-15 02:24 console

I think is not ok ?!


Now regarding some steps in the creation of the rootfs:

use "tmpfs" for cases where a writable file system is needed and add the
following lines to the /etc/rc.sh script:

# mount TMPFS because root-fs is readonly
/bin/mount -t tmpfs -o size=2M tmpfs /tmpfs

create the same symbolic links for device files that must be placed in a
writable filesystem:  dev/ptyp0 → /tmpfs/dev/ptyp0     dev/ttyp0 →
/tmpfs/dev/ttyp0
 dev/ptyp1 → /tmpfs/dev/ptyp1     dev/ttyp1 → /tmpfs/dev/ttyp1
dev/ptyp2 → /tmpfs/dev/ptyp2
    dev/ttyp2 → /tmpfs/dev/ttyp2  dev/ptyp3 → /tmpfs/dev/ptyp3     dev/ttyp3
→ /tmpfs/dev/ttyp3  dev/ptyp4 → /tmpfs/dev/ptyp4     dev/ttyp4 →
/tmpfs/dev/ttyp4
 dev/ptyp5 → /tmpfs/dev/ptyp5     dev/ttyp5 → /tmpfs/dev/ttyp5
dev/ptyp6 → /tmpfs/dev/ptyp6
    dev/ttyp6 → /tmpfs/dev/ttyp6  dev/ptyp7 → /tmpfs/dev/ptyp7     dev/ttyp7
→ /tmpfs/dev/ttyp7  dev/ptyp8 → /tmpfs/dev/ptyp8     dev/ttyp8 →
/tmpfs/dev/ttyp8
 dev/ptyp9 → /tmpfs/dev/ptyp9     dev/ttyp9 → /tmpfs/dev/ttyp9
dev/ptypa → /tmpfs/dev/ptypa
    dev/ttypa → /tmpfs/dev/ttypa  dev/ptypb → /tmpfs/dev/ptypb     dev/ttypb
→ /tmpfs/dev/ttypb  dev/ptypc → /tmpfs/dev/ptypc     dev/ttypc →
/tmpfs/dev/ttypc
 dev/ptypd → /tmpfs/dev/ptypd     dev/ttypd → /tmpfs/dev/ttypd
dev/ptype → /tmpfs/dev/ptype
    dev/ttype → /tmpfs/dev/ttype  dev/ptypf → /tmpfs/dev/ptypf     dev/ttypf
→ /tmpfs/dev/ttypf  tmp → /tmpfs/tmp     var → /tmpfs/var  dev/log →
/var/log/log
         In case you use dhclient also:  etc/dhclient.conf →
/tmpfs/var/lib/dhclient.conf
    etc/resolv.conf → /tmpfs/var/lib/resolv.conf
Shall I create the symlinks manually?
Is rc.sh executed ??

I,ve created a tmpfs directory in my rootfs directory and even if I mount it
on my host it's not populateed.
  place the corresponding directories and device files in the tmpfs file
system, the following code is added to the /etc/rc.sh script:

mkdir -p /tmpfs/tmp /tmpfs/dev \
         /tmpfs/var/lib/dhcp /tmpfs/var/lock /tmpfs/var/run

while read name minor
do
        mknod /tmpfs/dev/ptyp$name c 2 $minor
        mknod /tmpfs/dev/ttyp$name c 3 $minor
done <<__EOD__
0  0
1  1
2  2
3  3
4  4
5  5
6  6
7  7
8  8
9  9
a 10
b 11
c 12
d 13
e 14
f 15
__EOD__
chmod 0666 /tmpfs/dev/*



Cristian

------=_Part_17152_3586432.1226747707870
Content-Type: text/html; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Sat, Nov 15, 2008 at 12:40 PM, Nicholas Mc Guire <span dir="ltr">&lt;<a href="mailto:hofrat@hofr.at">hofrat@hofr.at</a>&gt;</span> wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">&gt; &gt;<br>
&gt; &gt; did you check that it is actually a valid character device (c 5 1) ?<br>
&gt; &gt; it can easaly happend during copying of a tree into your image that<br>
&gt; &gt; they become regular files.<br>
&gt; &gt;<br>
&gt; &gt; hofrat<br>
&gt; &gt;<br>
&gt; I think that you are right, butr how can I test this validity??<br>
&gt;<br>
</div>just check with ls -l that the device file is actually still a character<br>
device with the right major/minor number.<br>
<br>
crw--w--w- &nbsp; &nbsp;1 root &nbsp; &nbsp; tty &nbsp; &nbsp; &nbsp; &nbsp;5, &nbsp; 1 Nov 13 22:18 /mnt/dev/console<br>
<br>
modes and date of course may be diferent.<br>
<br>
hofrat<br>
</blockquote></div><br>I mount my ext2.img and run ls -l and I get<br><br>crw-r----- 1 root root&nbsp;&nbsp; 5,&nbsp;&nbsp; 1 2008-11-15 02:24 console<br><br>I think is not ok ?!<br><br><br>Now regarding some steps in the creation of the rootfs:<br>
<br>use
     <code>&quot;tmpfs&quot;</code> for cases where a writable file system is
     needed and add the
     following lines to the <code>/etc/rc.sh</code> script:
     <pre># mount TMPFS because root-fs is readonly<br>/bin/mount -t tmpfs -o size=2M tmpfs /tmpfs<br></pre>
     create the same symbolic links for device files
     that must be placed in a writable filesystem:
                          <table border="0" cellpadding="0" cellspacing="3">
     <tbody><tr><td class="twikiFirstCol"> dev/ptyp0 </td><td> → </td><td> /tmpfs/dev/ptyp0 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp0 </td><td> → </td><td> /tmpfs/dev/ttyp0 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp1 </td><td> → </td><td> /tmpfs/dev/ptyp1 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp1 </td><td> → </td><td> /tmpfs/dev/ttyp1 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp2 </td><td> → </td><td> /tmpfs/dev/ptyp2 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp2 </td><td> → </td><td> /tmpfs/dev/ttyp2 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp3 </td><td> → </td><td> /tmpfs/dev/ptyp3 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp3 </td><td> → </td><td> /tmpfs/dev/ttyp3 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp4 </td><td> → </td><td> /tmpfs/dev/ptyp4 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp4 </td><td> → </td><td> /tmpfs/dev/ttyp4 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp5 </td><td> → </td><td> /tmpfs/dev/ptyp5 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp5 </td><td> → </td><td> /tmpfs/dev/ttyp5 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp6 </td><td> → </td><td> /tmpfs/dev/ptyp6 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp6 </td><td> → </td><td> /tmpfs/dev/ttyp6 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp7 </td><td> → </td><td> /tmpfs/dev/ptyp7 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp7 </td><td> → </td><td> /tmpfs/dev/ttyp7 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp8 </td><td> → </td><td> /tmpfs/dev/ptyp8 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp8 </td><td> → </td><td> /tmpfs/dev/ttyp8 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptyp9 </td><td> → </td><td> /tmpfs/dev/ptyp9 </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttyp9 </td><td> → </td><td> /tmpfs/dev/ttyp9 </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptypa </td><td> → </td><td> /tmpfs/dev/ptypa </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttypa </td><td> → </td><td> /tmpfs/dev/ttypa </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptypb </td><td> → </td><td> /tmpfs/dev/ptypb </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttypb </td><td> → </td><td> /tmpfs/dev/ttypb </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptypc </td><td> → </td><td> /tmpfs/dev/ptypc </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttypc </td><td> → </td><td> /tmpfs/dev/ttypc </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptypd </td><td> → </td><td> /tmpfs/dev/ptypd </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttypd </td><td> → </td><td> /tmpfs/dev/ttypd </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptype </td><td> → </td><td> /tmpfs/dev/ptype </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttype </td><td> → </td><td> /tmpfs/dev/ttype </td></tr>
     <tr><td class="twikiFirstCol"> dev/ptypf </td><td> → </td><td> /tmpfs/dev/ptypf </td><td> &nbsp;&nbsp;&nbsp; </td><td> dev/ttypf </td><td> → </td><td> /tmpfs/dev/ttypf </td></tr>
     <tr><td class="twikiFirstCol"> tmp </td><td> → </td><td> /tmpfs/tmp </td><td> &nbsp;&nbsp;&nbsp; </td><td> var </td><td> → </td><td> /tmpfs/var </td></tr>
     <tr><td class="twikiFirstCol"> dev/log </td><td> → </td><td> /var/log/log </td><td> &nbsp; </td><td> &nbsp; </td><td> &nbsp; </td><td> &nbsp; </td></tr>
     <tr><td colspan="7" class="twikiFirstCol"> In case you use dhclient also: </td></tr>
     <tr><td class="twikiFirstCol"> etc/dhclient.conf </td><td> → </td><td> /tmpfs/var/lib/dhclient.conf </td><td> &nbsp;&nbsp;&nbsp; </td><td> etc/resolv.conf </td><td> → </td><td> /tmpfs/var/lib/resolv.conf </td></tr>
     </tbody></table>
     <br>Shall I create the symlinks manually? <br>Is rc.sh executed ??<br><br>I,ve created a tmpfs directory in my rootfs directory and even if I mount it on my host it&#39;s not populateed.<br>&nbsp;
     place the corresponding directories and device files
     in the <code>tmpfs</code> file system,
     the following code is added to the <code>/etc/rc.sh</code> script: 
     <pre>mkdir -p /tmpfs/tmp /tmpfs/dev \<br>         /tmpfs/var/lib/dhcp /tmpfs/var/lock /tmpfs/var/run<br><br>while read name minor<br>do      <br>        mknod /tmpfs/dev/ptyp$name c 2 $minor<br>        mknod /tmpfs/dev/ttyp$name c 3 $minor<br>
done &lt;&lt;__EOD__<br>0  0    <br>1  1    <br>2  2    <br>3  3    <br>4  4    <br>5  5    <br>6  6    <br>7  7    <br>8  8    <br>9  9    <br>a 10    <br>b 11    <br>c 12    <br>d 13    <br>e 14    <br>f 15    <br>__EOD__ <br>
chmod 0666 /tmpfs/dev/*<br></pre><br><br>Cristian<br><br>

------=_Part_17152_3586432.1226747707870--
