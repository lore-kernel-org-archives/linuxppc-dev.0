To: <linuxppc-dev@lists.linuxppc.org>
Subject: hdparm and disc errors
From: Jiri Masik <masik@pc203b.fzu.cz>
Date: 21 Sep 2001 15:43:49 +0200
Message-ID: <4vr8t0veui.fsf@darbujan.fzu.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I've been using hdparm -a16 -u1 /dev/hda (internal disc, Pismo) in
attempt to speed up my jobs analyzing large amounts of data (~1GB).
The jobs were utilizing just small fraction of CPU (20%) while
spending most of the time in disc-wait state. I thought this might
improve the performance a bit and for a long time there were no
problems with older kernels (2.2 series and first versions of 2.4).
However I'm getting disc errors nowadays.

I've been running version 2.4.8-ben0 (root@pbuk) (gcc version 2.95.4
20010721 (Debian prerelease)) #2 Wed Aug 15 13:23:41 CEST 2001 for the
last month mostly without touching the disc with hdparm and haven't
noticed any malfunction of the disc (I have also run badblocks many
times). When hdparm -a16 -u1 is invoked high disc load leads to the
following disc errors quite often

Sep 18 22:42:06 localhost kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Sep 18 22:42:06 localhost kernel: hda: dma_intr: error=0x40 { UncorrectableError }, CHS=45642/0/88, sector=99376
Sep 18 22:42:06 localhost kernel: end_request: I/O error, dev 03:0d (hda), sector 99376
with about 10 faulty sectors reported.

Also moving back to 2.2 kernel there are no disc problems either (even
with hdparm).

Do you think it is a real disc failure or is anything wrong with the
hdparm setting? Is the unmasking dangerous for Pismo?
Thanks,
	Jiri

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 12416/15/63, sectors = 11733120, start = 0

 Model=BI-MADAR2-6000 0                        , FwRev=RAA25AA1, SerialNo=        A 0FFAA02909
 Config={ SoftSect DTR>5Mbs RotSpdTol>.5% dStbOff FmtGapReq }
 RawCHS=32816/3840/16128, TrkSize=0, SectSize=0, ECCbytes=1024
 BuffType=768, BuffSize=8705kB, MaxMultSect=16, MultSect=off
 (maybe): CurCHS=32816/3840/16128, CurSects=-2146913536, LBA=yes, LBAsects=-2146913536
 IORDY=on/off
 PIO modes: pio0 pio1 pio2
 DMA modes: ***

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
