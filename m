Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 7568B67B7A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 19:56:05 +1000 (EST)
Date: Sat, 16 Sep 2006 11:56:03 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] oops in snd-powermac due to snd-aoa
Message-ID: <20060916095603.GA5447@aepfle.de>
References: <20060907124256.GA22928@aepfle.de> <s5h64fzltyg.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <s5h64fzltyg.wl%tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 07, Takashi Iwai wrote:

> At Thu, 7 Sep 2006 14:42:56 +0200,
> Olaf Hering wrote:
> > 
> > I was playing with snd-aoa, maybe the driver would work on a G4/466.
> > mv /lib/modules/*/kernel/sound/ppc/snd-powermac.ko .
> > reboot
> > $insmod /lib/modules/*/kernel/sound/aoa/*/*.ko
> > alsamixer finds nothing.
> > mv snd-powermac.ko /lib/modules/*/kernel/sound/ppc/
> > $insmod snd-powermac.ko -> oops
> > 
> > Using PowerMac machine description
> (snip)
> > ALSA sound/ppc/keywest.c:82: tumbler: cannot attach i2c client
> > read_audio_gpio addr 67 ret 2 av 4
> > headphone: 0, lineout: 0
> > check_audio_gpio addr 70 ret 4 av 4
> > check_audio_gpio addr 6f ret 7 av 4
> > Unable to handle kernel paging request for data at address 0x00000002
> 
> Does the patch below work?

Yes, no oops, but also no sound without reboot. Thats ok.

...
ALSA sound/ppc/keywest.c:82: tumbler: cannot attach i2c client
read_audio_gpio addr 67 ret 2 av 4
headphone: 0, lineout: 0
check_audio_gpio addr 70 ret 4 av 4
check_audio_gpio addr 6f ret 7 av 4
date:~ # 
date:~ # alsamixer 

alsamixer: function snd_ctl_open failed for default: No such device
...
