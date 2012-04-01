Return-Path: <whitebox@nefkom.net>
From: Andreas Schwab <schwab@linux-m68k.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map;
 use irq_alloc_desc() instead
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
Date: Sun, 01 Apr 2012 23:27:44 +0200
In-Reply-To: <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 (Grant Likely's message of "Thu, 16 Feb 2012 02:09:07 -0700")
Message-ID: <m2iphj3zxr.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Rob Herring <rob.herring@calxeda.com>,
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

Grant Likely <grant.likely@secretlab.ca> writes:

> This patch drops the powerpc-specific irq_map table and replaces it with
> directly using the irq_alloc_desc()/irq_free_desc() interfaces for allocating
> and freeing irq_desc structures.

This breaks irqs on PowerMac G5.  I see lost irq errors from the sata
driver.

Note that the breakage only started after the series was merged into
mainline.  But when transplanted upon the parent of the merge this is
the commit that was blamed by bisect.  So something changed between
v3.3-rc3 and the merge of this series that broke it.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
