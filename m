Return-Path: <keith.conger@gmail.com>
Received: from mproxy.gmail.com (mproxy.gmail.com [216.239.56.245])
	by ozlabs.org (Postfix) with ESMTP id 348302BDB5
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Nov 2004 03:58:26 +1100 (EST)
Received: by mproxy.gmail.com with SMTP id u33so120497cwc
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2004 08:58:25 -0800 (PST)
Message-ID: <4517b8e0411220858256619b4@mail.gmail.com>
Date: Mon, 22 Nov 2004 11:58:25 -0500
From: Keith Conger <keith.conger@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <4517b8e04112208383cc9b24c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1100847411.25521.42.camel@gaston> <1100852423.3855.2.camel@gaston>
	<1101083578.13597.5.camel@gaston> <6ullcuggfr.fsf@zork.zork.net>
	<4517b8e04112208383cc9b24c@mail.gmail.com>
Subject: Re: TEST: Sleep patch #4
Reply-To: Keith Conger <keith.conger@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Two things I forgot to include, the sound problem happens with or
without going to sleep. Also here is something that apears in my
dmesg:
Oops: kernel access of bad area, sig: 11 [#3]
PREEMPT
NIP: D22FB074 LR: D22FB8C0 SP: C548FDB0 REGS: c548fd00 TRAP: 0300   
Not taintedMSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: D23032A4, DSISR: 40000000
TASK = cfe60c90[10505] 'gst-launch-0.8' THREAD: c548e000Last syscall: 4
GPR00: 000007FC C548FDB0 CFE60C90 CDE724A0 C0BA6AA0 C0BA6580 00000200 00000B03
GPR08: C0BA6AE8 D2302AA8 000007FC D2302AE8 CDE72244 1001C6C4 00000014 10021340
GPR16: 00000003 100213F8 00000000 10021340 3007502C 00001000 1002D028 00000000
GPR24: 00000000 00000000 C07579A0 00000000 C0BA6AA0 CDE72510 CDE724A0 00000200
NIP [d22fb074] resample_expand+0x44/0x35c [snd_pcm_oss]
LR [d22fb8c0] rate_transfer+0x80/0x88 [snd_pcm_oss]
Call trace:
 [d22fb8c0] rate_transfer+0x80/0x88 [snd_pcm_oss]
 [d22f8798] snd_pcm_plug_write_transfer+0xd4/0x14c [snd_pcm_oss]
 [d22f3520] snd_pcm_oss_write2+0xb0/0x128 [snd_pcm_oss]
 [d22f3774] snd_pcm_oss_write1+0x1dc/0x20c [snd_pcm_oss]
 [d22f6180] snd_pcm_oss_write+0x64/0xb4 [snd_pcm_oss]
 [c0069c44] vfs_write+0xdc/0x158
 [c0069da4] sys_write+0x50/0x94
 [c0007e30] ret_from_syscall+0x0/0x4c
adt746x: Setting speed to: 128 for CPU fan.
adt746x: Stopping CPU fan.
adt746x: Setting speed to: 0 for CPU fan.
adt746x: Setting speed to: 128 for CPU fan.
Oops: kernel access of bad area, sig: 11 [#4]
PREEMPT
NIP: D22FB074 LR: D22FB8C0 SP: C5C33DB0 REGS: c5c33d00 TRAP: 0300   
Not taintedMSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: D23032A4, DSISR: 40000000
TASK = c78cac90[10759] 'gst-launch-0.8' THREAD: c5c32000Last syscall: 4
GPR00: 000007FC C5C33DB0 C78CAC90 CDE724A0 CF2D97C0 CFFD7BA0 00000200 00000B03
GPR08: C0BA6A88 D2302AA8 000007FC D2302AE8 CDE72844 1001C6C4 00000014 10021340
GPR16: 00000003 100213F8 00000000 10021340 3007502C 00001000 1002D028 00000000
GPR24: 00000000 00000000 C07579A0 00000000 CF2D97C0 CDE72510 CDE724A0 00000200
NIP [d22fb074] resample_expand+0x44/0x35c [snd_pcm_oss]
LR [d22fb8c0] rate_transfer+0x80/0x88 [snd_pcm_oss]
Call trace:
 [d22fb8c0] rate_transfer+0x80/0x88 [snd_pcm_oss]
 [d22f8798] snd_pcm_plug_write_transfer+0xd4/0x14c [snd_pcm_oss]
 [d22f3520] snd_pcm_oss_write2+0xb0/0x128 [snd_pcm_oss]
 [d22f3774] snd_pcm_oss_write1+0x1dc/0x20c [snd_pcm_oss]
 [d22f6180] snd_pcm_oss_write+0x64/0xb4 [snd_pcm_oss]
 [c0069c44] vfs_write+0xdc/0x158
 [c0069da4] sys_write+0x50/0x94
 [c0007e30] ret_from_syscall+0x0/0x4c



On Mon, 22 Nov 2004 11:38:09 -0500, Keith Conger <keith.conger@gmail.com> wrote:
> Hi,
> 
> Works great here also (15" 1GHz PB). One issue which may be unrelated
> I have some sound issues. For instance one a sound is played it sounds
> fine but if a sound is played right after its volume is extremely low.
> But with headphones this doesn't occur.
> 
> Thanks again for your hard work.
> 
> Keith
> 
> 
> 
> 
> On Mon, 22 Nov 2004 13:29:44 +0000, Sean Neakums <sneakums@zork.net> wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> >
> > > Ok, here's the 4th iteration of the patch. It includes John Steele
> > > Scott fixes for cpufreq and the sound driver and fixes a problem
> > > where memory refresh wouldn't properly be re-enabled on the video
> > > chip upon wakeup. I also cleaned a bit more the MDLL reset code for
> > > r300, plus a couple of other things.
> > >
> > > http://gate.crashing.org/~benh/albook-ibookg4-sleep-4.diff
> >
> > Works great now (15" 1.5GHz PB).
> >
> > Many thanks!
> >
> >
> >
> >
> > --
> > To UNSUBSCRIBE, email to debian-powerpc-REQUEST@lists.debian.org
> > with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
> >
> >
> 
> 
> --
> Keith Conger
> keith DOT conger AT gmail DOT com
> http://pimpstation.org
> 


-- 
Keith Conger
keith DOT conger AT gmail DOT com
http://pimpstation.org
