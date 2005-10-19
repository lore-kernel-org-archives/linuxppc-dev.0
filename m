Return-Path: <blackrocketman@gmail.com>
Received: from qproxy.gmail.com (qproxy.gmail.com [72.14.204.197])
	by ozlabs.org (Postfix) with ESMTP id 50882685F4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 03:42:53 +1000 (EST)
Received: by qproxy.gmail.com with SMTP id q17so152760qba
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Oct 2005 10:42:52 -0700 (PDT)
Message-ID: <b06af6180510191036o7d1d5b33tadf8b04018219eea@mail.gmail.com>
Date: Wed, 19 Oct 2005 11:36:24 -0600
From: Andrew McCarthy <andrew@thediligent.com>
Sender: blackrocketman@gmail.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8274_24014424.1129743384607"
Subject: PPC 440 / JFFS2 checksum question.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_8274_24014424.1129743384607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

We have some PPC440GX based blade servers that boot
from flash. My boss wants me to add
additional checksums somewhere in the JFFS2 partitions
as an overall check of the JFFS2 filesystem images that
we burn to flash. Once the image is burned, that file
system is never written to again. (That's the theory anyway).
So every time they boot they want to read these checksum
out of the flash and use it to decide if they want to/can boot
with that filesystem or fallback to another one.
 Each copy of the kernel has its own JFFS2 partition.
The root file system has its own JFFS2 partition. I don't
understand why they don't just write everything to one
JFFS2 partition. They say it is because they are
worried about power failure while writing to the flash and want
to isolate any write failures.
( I tried to tell them that the journaling already handles
that case quite well - but they are non-believers)
 Some questions;
 1) Is a filesystem-wide checksum really necessary or
is it kind of silly?
 1.1) Doesn't JFFS2 already do some integrity checking after
it finishes writing a file? Are there checksums or anything that
serves the same function? They want to avoid having to
checksum the entire filesystem at boot time (due to quick
boot time requirements) - is there some field or fields, or technique that
can quickly tell me if the filesystem is ok?
 2) Is there any place within the bounds of a JFFS2
partition that is safe from being overwritten? before and
after checksums could be placed there.
 2.1) Is there any way to create such a place? for example,
by appending the checksums to the end of some filesystem-wide
structure like a super block? Or maybe it can be hidden in
a couple of inodes that are never overwritten.
 What I'm looking for regarding this adding extra checksums into the
JFFS2 image is:
 3.1) How can it be done?
3.2) Why might it be unnecessary or even inadvisable?
3.3) Why can't it be done?
 Once I understand the answers to these questions I can
go back and see what they want to do.
 In the meantime, I am dumping and analyzing the JFFS2
filesystems we have and reading the code trying to find the
answers.
 thanks for your time.

------=_Part_8274_24014424.1129743384607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>We&nbsp;have some&nbsp;PPC440GX based blade servers that boot</div>
<div>from flash.&nbsp; My boss wants me&nbsp;to add</div>
<div>additional checksums somewhere in the JFFS2 partitions</div>
<div>as an overall check of the JFFS2 filesystem images that</div>
<div>we burn to flash.&nbsp; Once the image is burned, that file</div>
<div>system is never written to again.&nbsp; (That's the theory anyway). </=
div>
<div>So every time they boot they want to read these checksum</div>
<div>out of the flash and use it to decide if they want to/can boot</div>
<div>with that filesystem or fallback to another one.&nbsp; </div>
<div>&nbsp;</div>
<div>Each copy of the &nbsp;kernel has its own JFFS2 partition.&nbsp;&nbsp;=
</div>
<div>The root file system has its own JFFS2 partition.&nbsp; I don't </div>
<div>understand why they don't just write everything to one </div>
<div>JFFS2 partition.&nbsp; They say it is because they are </div>
<div>worried about power failure while writing to the flash and want </div>
<div>to isolate any write failures.&nbsp; </div>
<div>( I tried to tell them that the journaling already handles </div>
<div>that case quite well - but they are non-believers)</div>
<div>&nbsp;</div>
<div>Some questions;</div>
<div>&nbsp;</div>
<div>1)&nbsp; Is a filesystem-wide checksum really necessary or</div>
<div>is it kind of silly?</div>
<div>&nbsp;</div>
<div>1.1)&nbsp; Doesn't JFFS2 already do some integrity checking after</div=
>
<div>it finishes writing a file?&nbsp; Are there checksums or anything that=
 </div>
<div>serves the same function?&nbsp;&nbsp;&nbsp;&nbsp;They want to avoid ha=
ving to </div>
<div>checksum the entire filesystem at boot time (due to quick<span></span>=
 </div>
<div>boot time requirements) - is there some field or fields, or technique&=
nbsp;that</div>
<div>can quickly tell me if the filesystem is ok?</div>
<div>&nbsp;</div>
<div>2)&nbsp; Is there any place within the bounds of a JFFS2 </div>
<div>partition that is safe from being overwritten?&nbsp; before and </div>
<div>after checksums could be placed there.</div>
<div>&nbsp;</div>
<div>2.1)&nbsp; Is there any way to create such a place?&nbsp; for example,=
</div>
<div>by appending the&nbsp;checksums to the end of some filesystem-wide</di=
v>
<div>structure like a super block?&nbsp; Or maybe it can be hidden in </div=
>
<div>a couple of inodes that are never overwritten.</div>
<div>&nbsp;</div>
<div>What I'm looking for regarding this adding extra checksums into the</d=
iv>
<div>JFFS2 image is:</div>
<div>&nbsp;</div>
<div>3.1)&nbsp; How can it be done?</div>
<div>3.2)&nbsp; Why might it be unnecessary or even inadvisable?</div>
<div>3.3)&nbsp; Why can't it be done?</div>
<div>&nbsp;</div>
<div>Once I understand the answers to these&nbsp; questions I can </div>
<div>go back and see what they want to do.</div>
<div>&nbsp;</div>
<div>In the meantime, I am dumping and analyzing the JFFS2 </div>
<div>filesystems we have and reading the code trying to find the </div>
<div>answers.</div>
<div>&nbsp;</div>
<div>thanks for your time.</div><span class=3D"sg">
<div>&nbsp;</div></span>

------=_Part_8274_24014424.1129743384607--
