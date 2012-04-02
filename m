Return-Path: <benh@kernel.crashing.org>
Message-ID: <1333340517.30734.42.camel@pasglop>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Mon, 02 Apr 2012 14:21:57 +1000
In-Reply-To: <m2iphj3zxr.fsf@igel.home>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2012-04-01 at 23:27 +0200, Andreas Schwab wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
> 
> > This patch drops the powerpc-specific irq_map table and replaces it with
> > directly using the irq_alloc_desc()/irq_free_desc() interfaces for allocating
> > and freeing irq_desc structures.
> 
> This breaks irqs on PowerMac G5.  I see lost irq errors from the sata
> driver.
> 
> Note that the breakage only started after the series was merged into
> mainline.  But when transplanted upon the parent of the merge this is
> the commit that was blamed by bisect.  So something changed between
> v3.3-rc3 and the merge of this series that broke it.

can you tell me more ? (What machine precisely, what .config etc...) ?

I tested here on two G5's:

 - PowerMac7,3 aka Dual G5 AGP. This ones has U3 + K2 and
uses cascaded MPICs

 - PowerMac11,2 aka Quad G5. This one has U4 + K2 and uses a single MPIC
in the northbridge

And both appear to work fine with today upstream (basically -rc1).

Cheers,
Ben.
