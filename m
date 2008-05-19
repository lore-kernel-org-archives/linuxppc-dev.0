Return-Path: <gicoviello@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 5A122DDEE0
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 03:23:11 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so861764nfd.9
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 10:23:09 -0700 (PDT)
Subject: Re: ALSA fixes for non-coherent archs (Re: [PATCH] Sam440ep support)
From: Giuseppe Coviello <cjg@cruxppc.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hr6c5ax6a.wl%tiwai@suse.de>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
	<20080505195054.172000@gmx.net> <1210031058.21644.120.camel@pasglop>
	<20080506075115.269150@gmx.net> <1210063719.21644.162.camel@pasglop>
	<20080506091622.269180@gmx.net>  <s5hr6c5ax6a.wl%tiwai@suse.de>
Content-Type: text/plain
Date: Mon, 19 May 2008 19:23:10 +0200
Message-Id: <1211217790.2037.3.camel@marquez.cjg.home>
Mime-Version: 1.0
Sender: Giuseppe Coviello <gicoviello@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On mer, 14/05/2008 14.26 +0200, Takashi Iwai wrote:
[cut]
> OK, here is another patch for testing.  Since I lost my old patch
> somewhere (and it's not worth to dig the archive), I wrote it up
> quickly from scratch.  This version should cover both SG and non-SG
> buffers.  It's against the latest git tree.
> 
> The patch adds a hackish verison of dma_mmap_coherent() for some
> architectures in sound/core/pcm_native.c.  I'm not sure whether this
> works.  I just tested it on X86.  It'd be appreciated if someone can
> test this.
> 
> Also, this disables HDSPM driver for non-X86/IA64 since the driver has
> own copy and silence methods that are incompatible with the new
> SG-buffer data.
> 
> 
> And, yes, I know we need to clean up huge messes in ALSA memory
> handling routines.  But, let's fix obvious bugs before starting a big
> rewrite...
> 

I've just tested this patch on the sam440ep and it works great (and
sounds great, of course). I had also to make the following changes:

Signed-off-by: Giuseppe Coviello <gicoviello@gmail.com>

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 7556fd9..f5f208e 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -952,6 +952,9 @@ static struct snd_pcm_ops snd_cs4281_playback_ops = {
 	.prepare =	snd_cs4281_playback_prepare,
 	.trigger =	snd_cs4281_trigger,
 	.pointer =	snd_cs4281_pointer,
+	.copy =         snd_pcm_sgbuf_ops_copy,
+	.silence =      snd_pcm_sgbuf_ops_silence,
+       .page =         snd_pcm_sgbuf_ops_page,
 };
 
 static struct snd_pcm_ops snd_cs4281_capture_ops = {
@@ -963,6 +966,8 @@ static struct snd_pcm_ops snd_cs4281_capture_ops = {
 	.prepare =	snd_cs4281_capture_prepare,
 	.trigger =	snd_cs4281_trigger,
 	.pointer =	snd_cs4281_pointer,
+	.copy =         snd_pcm_sgbuf_ops_copy,
+       .page =         snd_pcm_sgbuf_ops_page,
 };
 
 static int __devinit snd_cs4281_pcm(struct cs4281 * chip, int device,
