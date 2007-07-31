Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0189DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 21:49:10 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IFqDr-0007Tz-O8
	for linuxppc-embedded@ozlabs.org; Tue, 31 Jul 2007 04:49:07 -0700
Message-ID: <11922613.post@talk.nabble.com>
Date: Tue, 31 Jul 2007 04:49:07 -0700 (PDT)
From: Qin Lin <linkinge@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: BUG-REPORT Re: ml403 ac97 driver
In-Reply-To: <1185698888.6397.37.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <1185698888.6397.37.camel@localhost>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


HI Joachim


When i used the aplay to test the drive first time,it played well. But 
after restart the board 
it is not well again.

Qin Lin

# aplay yonggan.wav
Playing WAVE 'yonggan.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
[  258.518119] Kernel stack overflow in process c039ec00, r1=c3e0bf50

#strace  aplay yonggan.wav
......................
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=7701,
...}) = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0x7f9a25b8)  = 0
ioctl(3, 0x41785501, 0x7f9a2560)        = 0
close(3)                                = 0
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 3
ioctl(3, USBDEVFS_CONTROL, 0x7f9a2808)  = 0
ioctl(3, 0x80045532, 0x7f9a2838)        = 0
open("/dev/snd/pcmC0D0p", O_RDWR|O_NONBLOCK) = 4
close(3)                                = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0x7f9a2718) = 0
fcntl64(4, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
ioctl(4, AGPIOC_INFO, 0x7f9a2688)       = 0
ioctl(4, AGPIOC_RELEASE or APM_IOC_SUSPEND, 0x7f9a2690) = 0
mmap(NULL, 4096, PROT_READ, MAP_SHARED, 4, 0x80000000) = 0x30018000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 4, 0x81000000) =
0x30019000
fcntl64(4, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl64(4, F_SETFL, O_RDWR)             = 0
ioctl(4, AGPIOC_ACQUIRE or APM_IOC_STANDBY, 0x7f9a2c60) = 0
rt_sigaction(SIGINT, {0xfdabf30, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0xfdabf30, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0xfdabf30, [ABRT], SA_RESTART}, {SIG_DFL}, 8) = 0
open("yonggan.wav", O_RDONLY|O_LARGEFILE) = 3
read(3, "RIFF$VR\0WAVEfmt \20\0\0\0\1\0\2\0", 24) = 24
read(3, "D\254", 2)                     = 2
read(3, "\0\0\20\261\2\0\4\0\20\0", 10) = 10
read(3, "data\\TR\0", 8)                = 8
write(2, "Playing WAVE \'yonggan.wav\' : ", 29Playing WAVE 'yonggan.wav' : )
= 29
write(2, "Signed 16 bit Little Endian, ", 29Signed 16 bit Little Endian, ) =
29
write(2, "Rate 44100 Hz, ", 15Rate 44100 Hz, )         = 15
write(2, "Stereo", 6Stereo)                   = 6
write(2, "\n", 1
)                       = 1
ioctl(4, 0xc25c4110, 0x7f9a2518)        = 0
ioctl(4, 0xc25c4110, 0x7f9a21b0)        = 0
ioctl(4, 0xc25c4110, 0x7f9a21b0)        = 0
ioctl(4, 0xc25c4110, 0x7f9a2518)        = 0
ioctl(4, 0xc25c4110, 0x7f9a21b0)        = 0
ioctl(4, 0xc25c4110, 0x7f9a21b0)        = 0
ioctl(4, 0xc25c4110, 0x7f9a2518)        = 0
ioctl(4, 0xc25c4110, 0x7f9a2298)        = 0
ioctl(4, 0xc25c4110, 0x7f9a1f30)        = 0
ioctl(4, 0xc25c4110, 0x7f9a1f30)        = 0
ioctl(4, 0xc25c4110, 0x7f9a2298)        = 0
ioctl(4, 0xc25c4110, 0x7f9a2298[  213.220781] Kernel stack overflow in
process c039c030, r1=c0395f50


-- 
View this message in context: http://www.nabble.com/Re%3A-ml403-ac97-driver-tf4164866.html#a11922613
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
