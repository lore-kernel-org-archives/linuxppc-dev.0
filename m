Return-Path: <pol.vangheluwe@skynet.be>
Received: from mailrelay002.isp.belgacom.be (mailrelay002.isp.belgacom.be
	[195.238.6.175]) by ozlabs.org (Postfix) with ESMTP id A253CB6EE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  5 Aug 2011 05:40:50 +1000 (EST)
From: Pol Vangheluwe <pol.vangheluwe@skynet.be>
Content-Type: multipart/alternative; boundary=Apple-Mail-1--827803345
Subject: MESH SCSI driver not working
Date: Thu, 4 Aug 2011 21:40:45 +0200
Message-Id: <F0034E2F-AAAD-4DAC-A35A-E532B05B3210@skynet.be>
To: linuxppc-dev@lists.ozlabs.org
Mime-Version: 1.0 (Apple Message framework v1084)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail-1--827803345
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Fri, 2010-03-19 at 00:21 +0100, Stef Simoens wrote:
> Hello,
>=20
> Some time ago (July 24th 2009 my mailbox says) I emailed you and the
> linuxppc-dev list about my problems booting from the mesh SCSI
> controller.
>=20
> I just compiled 2.6.31 (actually, gentoo-sources-2.6.31-r10); but the
> problem remains
> I know that 2.6.33 is out, but as I didn't see any changes to the
> mesh-driver I guess that the problem is still there ...

Sadly I haven't had a chance to look. The MESH driver is a pretty
complicated thing that I didn't write and am not familiar with, so it's
going to take some work to sort out what's going on, and so far I
haven't had time to dedicate to this.

Cheers,
Ben.
I found this topic in the linuxppc-dev archives while googling for a =
mesh problem I currently have on my PowerPC 7500:
the boot process fails when populating /dev.  I think I have the same =
problem as reported by Stef Simoens: after a lot of complaints
like 'mesh_abort' and 'mesh_host_reset', it ends with Kernel panic about =
'double DMA start'.

A rebuilt my kernel several times with different configs, but the only =
way to make it bootable is to disable the CDROM driver
(the 'sr' block of the SCSI upper layer).  The problem even occurs when =
'sr' is built as a module.

My platform: pol [ ~ ]$ cat /proc/cpuinfo
processor	: 0
cpu		: 604e
clock		: 200.000000MHz
revision	: 2.4 (pvr 0009 0204)
bogomips	: 25.00
timebase	: 12500550
platform	: PowerMac
model		: Power Macintosh
machine		: Power Macintosh
motherboard	: AAPL,7500 MacRISC
detected as	: 16 (PowerMac 7500)
pmac flags	: 00000000
L2 cache	: 256K unified
pmac-generation	: OldWorld
Memory		: 208 MB

My kernel: pol [ ~ ]$ uname -a
Linux ppc7600 2.6.37.6 #4 Thu Aug 4 18:36:07 CEST 2011 ppc GNU/Linux

My compiler: pol [ ~ ]$ gcc -v      =20
Ingebouwde specs worden gebruikt.
COLLECT_GCC=3Dgcc
=
COLLECT_LTO_WRAPPER=3D/usr/lib/gcc/powerpc-unknown-linux-gnu/4.5.2/lto-wra=
pper
Target: powerpc-unknown-linux-gnu
Configured with: ../gcc-4.5.2/configure --prefix=3D/usr =
--libexecdir=3D/usr/lib --enable-shared --enable-threads=3Dposix =
--enable-__cxa_atexit --enable-clocale=3Dgnu --enable-languages=3Dc,c++ =
--disable-multilib --disable-bootstrap --with-system-zlib
Thread model: posix
gcc versie 4.5.2 (GCC)=20

My system: LFS-2.8 (Linux =46rom Scratch)

I have on the same machine also Ubuntu 8.04.1 (hardy), running the =
2.6.24-19-powerpc kernel=20
and gcc 4.1.3.  There is no mesh problem with this distribution.

Stef reported kernel 2.6.29 OK but 2.6.30-rcl and 2.6.31-rc3 NOK.

I recompiled mesh.c with DEBUG on and I see a lot of messages on the =
screen but I cannot capture them in a file.  We are too early
in the boot process for a working serial port and there is no disk =
mounted yet to log anything.

BenH was suspecting a DMA buffer misalignment but so far, I could not =
find a real solution on the Internet.
Anybody?

pvg


--Apple-Mail-1--827803345
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><pre>On Fri, 2010-03-19 at 00:21 +0100, Stef Simoens wrote:
&gt;<i> Hello,
</i>&gt;<i>=20
</i>&gt;<i> Some time ago (July 24th 2009 my mailbox says) I emailed you =
and the
</i>&gt;<i> linuxppc-dev list about my problems booting from the mesh =
SCSI
</i>&gt;<i> controller.
</i>&gt;<i>=20
</i>&gt;<i> I just compiled 2.6.31 (actually, =
gentoo-sources-2.6.31-r10); but the
</i>&gt;<i> problem remains
</i>&gt;<i> I know that 2.6.33 is out, but as I didn't see any changes =
to the
</i>&gt;<i> mesh-driver I guess that the problem is still there ...
</i>
Sadly I haven't had a chance to look. The MESH driver is a pretty
complicated thing that I didn't write and am not familiar with, so it's
going to take some work to sort out what's going on, and so far I
haven't had time to dedicate to this.

Cheers,
Ben.
</pre><div>I found this topic in the linuxppc-dev archives while =
googling for a mesh problem I currently have on my PowerPC =
7500:</div><div>the boot process fails when populating /dev. &nbsp;I =
think I have the same problem as reported by Stef Simoens: after a lot =
of complaints</div><div>like 'mesh_abort' and 'mesh_host_reset', it ends =
with Kernel panic about 'double DMA start'.</div><div><br></div><div>A =
rebuilt my kernel several times with different configs, but the only way =
to make it bootable is to disable the CDROM driver</div><div>(the 'sr' =
block of the SCSI upper layer). &nbsp;The problem even occurs when 'sr' =
is built as a module.</div><div><br></div><div>My platform:&nbsp;pol [ ~ =
]$ cat /proc/cpuinfo</div><div>processor<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>: 0</div><div>cpu<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>: =
604e</div><div>clock<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>: =
200.000000MHz</div><div>revision<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>: 2.4 (pvr 0009 =
0204)</div><div>bogomips<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>: 25.00</div><div>timebase<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>: =
12500550</div><div>platform<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>: PowerMac</div><div>model<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>: =
Power Macintosh</div><div>machine<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>: Power =
Macintosh</div><div>motherboard<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>: AAPL,7500 =
MacRISC</div><div>detected as<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>: 16 (PowerMac =
7500)</div><div>pmac flags<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>: 00000000</div><div>L2 =
cache<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>: =
256K unified</div><div>pmac-generation<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>: OldWorld</div><div>Memory<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">		</span>: =
208 MB</div><div><br></div><div>My kernel:&nbsp;pol [ ~ ]$ uname =
-a</div><div>Linux ppc7600 2.6.37.6 #4 Thu Aug 4 18:36:07 CEST 2011 ppc =
GNU/Linux</div><div><br></div><div>My compiler:&nbsp;pol [ ~ ]$ gcc -v =
&nbsp; &nbsp; &nbsp;&nbsp;</div><div>Ingebouwde specs worden =
gebruikt.</div><div>COLLECT_GCC=3Dgcc</div><div>COLLECT_LTO_WRAPPER=3D/usr=
/lib/gcc/powerpc-unknown-linux-gnu/4.5.2/lto-wrapper</div><div>Target: =
powerpc-unknown-linux-gnu</div><div>Configured with: =
../gcc-4.5.2/configure --prefix=3D/usr --libexecdir=3D/usr/lib =
--enable-shared --enable-threads=3Dposix --enable-__cxa_atexit =
--enable-clocale=3Dgnu --enable-languages=3Dc,c++ --disable-multilib =
--disable-bootstrap --with-system-zlib</div><div>Thread model: =
posix</div><div>gcc versie 4.5.2 (GCC)&nbsp;</div><div><br></div><div>My =
system: LFS-2.8 (Linux =46rom Scratch)</div><div><br></div><div>I have =
on the same machine also Ubuntu 8.04.1 (hardy), running the =
2.6.24-19-powerpc kernel&nbsp;</div><div>and gcc 4.1.3. &nbsp;There is =
no mesh problem with this distribution.</div><div><br></div><div>Stef =
reported kernel 2.6.29 OK but 2.6.30-rcl and 2.6.31-rc3 =
NOK.</div><div><br></div><div>I recompiled mesh.c with DEBUG on and I =
see a lot of messages on the screen but I cannot capture them in a file. =
&nbsp;We are too early</div><div>in the boot process for a working =
serial port and there is no disk mounted yet to log =
anything.</div><div><br></div><div>BenH was suspecting a DMA buffer =
misalignment but so far, I could not find a real solution on the =
Internet.</div><div>Anybody?</div><div>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica; =
min-height: 14.0px"><br></p>
<p style=3D"margin: 0.0px 0.0px 0.0px 0.0px"><font face=3D"Helvetica" =
size=3D"3" style=3D"font: 12.0px Helvetica">pvg</font></p>

</div>
<br></body></html>=

--Apple-Mail-1--827803345--
