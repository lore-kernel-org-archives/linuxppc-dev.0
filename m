Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id C44A5DDEE8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 01:44:05 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so101225anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 07 May 2008 08:44:01 -0700 (PDT)
Message-ID: <fa686aa40805070844m2af3d62aw58b54b94deb02e64@mail.gmail.com>
Date: Wed, 7 May 2008 09:44:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: ALSA vs. non coherent DMA
In-Reply-To: <4821BB0E.80000@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1210032508.21644.129.camel@pasglop> <s5hmyn3d7d5.wl%tiwai@suse.de>
	<4821BB0E.80000@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 7, 2008 at 8:22 AM, Timur Tabi <timur@freescale.com> wrote:
> Takashi Iwai wrote:
>
>  > This is a mmap of the data record to be shared in realtime with apps.
>  > The app updates its data pointer (appl_ptr) on the mmapped buffer
>  > while the driver updates the data (e.g. DMA position, called hwptr) on
>  > the fly on the mmapped record.  Due to its real-time nature, it has to
>  > be coherent -- at least, it was a problem on ARM.
>
>  This doesn't sound like a coherency problem to me, and least not one you'd find
>  on PowerPC.  Both the driver and the application run on the host CPU, so there
>  shouldn't be any coherency problem.  My understanding is that a "non coherent"
>  platform is one where the host CPU isn't aware when a *hardware device* writes
>  directly to memory, e.g. via DMA.

IIRC, some ARMs have a different situation because the dcache is
virtually instead of physically tagged.  Therefore, the kernel mapping
may not see data that has not been flushed out of the user space
mappings.  (Someone please correct me if I'm wrong).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
