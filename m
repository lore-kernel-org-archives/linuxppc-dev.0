Return-Path: <olof@lixom.net>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9E812C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 17:28:27 +1000 (EST)
Received: by wibhq4 with SMTP id hq4so417378wib.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 00:28:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120709182018.18165.98339.stgit@bhelgaas.mtv.corp.google.com>
References: <20120709181745.18165.93914.stgit@bhelgaas.mtv.corp.google.com>
 <20120709182018.18165.98339.stgit@bhelgaas.mtv.corp.google.com>
Date: Thu, 23 Aug 2012 00:28:23 -0700
Message-ID: <CAOesGMgUGUG9Z=x6ssumVkAxN6fHoeyAJ3-P8CoaNTGas7-vmg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: leave MEM and IO decoding disabled during 64-bit
 BAR sizing, too
From: Olof Johansson <olof@lixom.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matthew Wilcox <matthew.r.wilcox@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Robert Hancock <hancockrwd@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Jul 9, 2012 at 11:20 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> After 253d2e5498, we disable MEM and IO decoding for most devices while we
> size 32-bit BARs.  However, we restore the original COMMAND register before
> we size the upper 32 bits of 64-bit BARs, so we can still cause a conflict.
>
> This patch waits to restore the original COMMAND register until we're
> completely finished sizing the BAR.
>
> Reference: https://lkml.org/lkml/2007/8/25/154
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

This patch causes boot lockup on PA Semi hardware, since it disables
the bar on the UART that is used for console, and it has printks
between the old and the new re-enable location. If I boot with 'debug'
level for printk, I hit this. If I boot with just regular console
args, I don't.

I'm guessing any other platform that uses MMIO-based UART on PCI for
console will have similar issues. I can verify on Chrome OS x86
hardware tomorrow if legacy powerpc isn't important enough to care
about. :-)

I have no proposal for a fix for this. Can you please consider
reverting for 3.6 unless someone has a better idea?


-Olof
