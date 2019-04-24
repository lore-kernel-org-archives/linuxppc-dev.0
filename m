Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFACDC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF1B21905
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2JWgHdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF1B21905
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44q6Rr32d0zDqXR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Apr 2019 03:16:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=changbin.du@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="a2JWgHdk"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44q6Lm3fdHzDqX0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 03:12:15 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id 8so9645999pfr.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eZWh1XIr9E+rNynzA5Bk/3qLEbI5TXGu5UQ89AIK96Q=;
 b=a2JWgHdkZGHtmk9J4zn4BteK/rPnEejjt8VUPJRAcWgRYIj0B3HgSJdNKsCHMo5P57
 GfcvfHllBbpvprRJnyTp9a+FvDnTZdR9dsdzCw1YyxZt5Udb0P+ohWY5tMZDnMEejf4/
 bu5zYPdrRZYELbicm3GAdKvCr06lSCrLDqX2Q5Ulh9v+M82zZDES3yrIK0KqOU5TGlsg
 0xyDDikUHfjq98cFC7xS1iBMSqHNTSj3WoIdpJBuUB8LyS2JiUOFya4ShCMFVyT4PD/g
 BZhCWR1sDtieBBw3Q9BGn53GeuS42iLaCg5f7FlUXQVGAxpGvwQfvCjgYJa3eKUrNep+
 eu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eZWh1XIr9E+rNynzA5Bk/3qLEbI5TXGu5UQ89AIK96Q=;
 b=WFNgw2OP5ShC3WFksZRL+rD3qOnRCLcBU6XUU/mlgndpRkPgTPF1Bp4WU7BPL/JOGM
 5zLkh9If2oT/herT69knaQpbbFX2+CVSjrkVKdLxSCSu2rqNecwfz9rjOs/d2d6Lpnp6
 GBi0x8K/EBHmycWljOicrliHlVjUEpQy8XvJGB4Hz1KaWw8hr6PQOMSB5Ql+DlMeTzPI
 eUHEJc8/dWEgLuEMZbtWaC9Kl4qAHdd7Kb8Pca0xiZktgCEXcrI19q9Lj47D4xmSiqAO
 h23Dpi7QtF5cnI3gjodpj8WZaS/V9clYBbtDiMCGwwRwIZkonaJk7vr6f5FkAmBW6Jlr
 FvUQ==
X-Gm-Message-State: APjAAAXiSbvYfTAk8CzP9m5WoddnVQVu8MfLt4ZRa7vOnsH0Z7qFWqK9
 7pUlL2BO2yAeY+7HlDYHsb/aJLL7
X-Google-Smtp-Source: APXvYqyRGxTDQog2i24z7dpUzzwx+Dix5mBqoWFe8G2mPNs3xVGKLu74WSVWW7dS5yX/R5KlbEsicA==
X-Received: by 2002:aa7:8609:: with SMTP id p9mr34565712pfn.166.1556125932618; 
 Wed, 24 Apr 2019 10:12:12 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
 by smtp.gmail.com with ESMTPSA id m23sm27280774pfa.117.2019.04.24.10.12.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Apr 2019 10:12:11 -0700 (PDT)
Date: Thu, 25 Apr 2019 01:12:03 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH v4 20/63] Documentation: ACPI: move apei/einj.txt to
 firmware-guide/acpi and convert to reST
Message-ID: <20190424171201.fnuf6d534uhk6d2z@mail.google.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
 <20190423162932.21428-21-changbin.du@gmail.com>
 <20190424113349.79e1c577@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424113349.79e1c577@coco.lan>
User-Agent: NeoMutt/20180716
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: fenghua.yu@intel.com, x86@kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, mingo@redhat.com,
 Bjorn Helgaas <bhelgaas@google.com>, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, Changbin Du <changbin.du@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 24, 2019 at 11:33:49AM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 24 Apr 2019 00:28:49 +0800
> Changbin Du <changbin.du@gmail.com> escreveu:
> 
> > This converts the plain text documentation to reStructuredText format and
> > add it to Sphinx TOC tree. No essential content change.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  .../acpi/apei/einj.rst}                       | 98 ++++++++++---------
> >  Documentation/firmware-guide/acpi/index.rst   |  1 +
> >  2 files changed, 53 insertions(+), 46 deletions(-)
> >  rename Documentation/{acpi/apei/einj.txt => firmware-guide/acpi/apei/einj.rst} (67%)
> > 
> > diff --git a/Documentation/acpi/apei/einj.txt b/Documentation/firmware-guide/acpi/apei/einj.rst
> > similarity index 67%
> > rename from Documentation/acpi/apei/einj.txt
> > rename to Documentation/firmware-guide/acpi/apei/einj.rst
> > index e550c8b98139..d85e2667155c 100644
> > --- a/Documentation/acpi/apei/einj.txt
> > +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> > @@ -1,13 +1,16 @@
> > -			APEI Error INJection
> > -			~~~~~~~~~~~~~~~~~~~~
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +====================
> > +APEI Error INJection
> > +====================
> >  
> >  EINJ provides a hardware error injection mechanism. It is very useful
> >  for debugging and testing APEI and RAS features in general.
> >  
> >  You need to check whether your BIOS supports EINJ first. For that, look
> > -for early boot messages similar to this one:
> > +for early boot messages similar to this one::
> >  
> > -ACPI: EINJ 0x000000007370A000 000150 (v01 INTEL           00000001 INTL 00000001)
> > +  ACPI: EINJ 0x000000007370A000 000150 (v01 INTEL           00000001 INTL 00000001)
> >  
> >  which shows that the BIOS is exposing an EINJ table - it is the
> >  mechanism through which the injection is done.
> > @@ -23,11 +26,11 @@ order to see the APEI,EINJ,... functionality supported and exposed by
> >  the BIOS menu.
> >  
> >  To use EINJ, make sure the following are options enabled in your kernel
> > -configuration:
> > +configuration::
> >  
> > -CONFIG_DEBUG_FS
> > -CONFIG_ACPI_APEI
> > -CONFIG_ACPI_APEI_EINJ
> > +  CONFIG_DEBUG_FS
> > +  CONFIG_ACPI_APEI
> > +  CONFIG_ACPI_APEI_EINJ
> >  
> >  The EINJ user interface is in <debugfs mount point>/apei/einj.
> >  
> > @@ -35,22 +38,22 @@ The following files belong to it:
> >  
> >  - available_error_type
> >  
> > -  This file shows which error types are supported:
> > -
> > -  Error Type Value	Error Description
> > -  ================	=================
> > -  0x00000001		Processor Correctable
> > -  0x00000002		Processor Uncorrectable non-fatal
> > -  0x00000004		Processor Uncorrectable fatal
> > -  0x00000008		Memory Correctable
> > -  0x00000010		Memory Uncorrectable non-fatal
> > -  0x00000020		Memory Uncorrectable fatal
> > -  0x00000040		PCI Express Correctable
> > -  0x00000080		PCI Express Uncorrectable fatal
> > -  0x00000100		PCI Express Uncorrectable non-fatal
> > -  0x00000200		Platform Correctable
> > -  0x00000400		Platform Uncorrectable non-fatal
> > -  0x00000800		Platform Uncorrectable fatal
> > +  This file shows which error types are supported::
> > +
> > +    Error Type Value	Error Description
> > +    ================	=================
> > +    0x00000001		Processor Correctable
> > +    0x00000002		Processor Uncorrectable non-fatal
> > +    0x00000004		Processor Uncorrectable fatal
> > +    0x00000008		Memory Correctable
> > +    0x00000010		Memory Uncorrectable non-fatal
> > +    0x00000020		Memory Uncorrectable fatal
> > +    0x00000040		PCI Express Correctable
> > +    0x00000080		PCI Express Uncorrectable fatal
> > +    0x00000100		PCI Express Uncorrectable non-fatal
> > +    0x00000200		Platform Correctable
> > +    0x00000400		Platform Uncorrectable non-fatal
> > +    0x00000800		Platform Uncorrectable fatal
> 
> This is a table and not a literal block. 
> 
> The best here to preserve the author's intent is to just adjust the table 
> markups in order to make it parseable, e. g.:
> 
>   This file shows which error types are supported:
> 
>   ================	===================================
>   Error Type Value	Error Description
>   ================	===================================
>   0x00000001		Processor Correctable
>   0x00000002		Processor Uncorrectable non-fatal
>   0x00000004		Processor Uncorrectable fatal
>   0x00000008		Memory Correctable
>   0x00000010		Memory Uncorrectable non-fatal
>   0x00000020		Memory Uncorrectable fatal
>   0x00000040		PCI Express Correctable
>   0x00000080		PCI Express Uncorrectable fatal
>   0x00000100		PCI Express Uncorrectable non-fatal
>   0x00000200		Platform Correctable
>   0x00000400		Platform Uncorrectable non-fatal
>   0x00000800		Platform Uncorrectable fatal
>   ================	===================================
>
Done, thanks.

> After such change:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> >  
> >    The format of the file contents are as above, except present are only
> >    the available error types.
> > @@ -73,9 +76,12 @@ The following files belong to it:
> >    injection. Value is a bitmask as specified in ACPI5.0 spec for the
> >    SET_ERROR_TYPE_WITH_ADDRESS data structure:
> >  
> > -	Bit 0 - Processor APIC field valid (see param3 below).
> > -	Bit 1 - Memory address and mask valid (param1 and param2).
> > -	Bit 2 - PCIe (seg,bus,dev,fn) valid (see param4 below).
> > +    Bit 0
> > +      Processor APIC field valid (see param3 below).
> > +    Bit 1
> > +      Memory address and mask valid (param1 and param2).
> > +    Bit 2
> > +      PCIe (seg,bus,dev,fn) valid (see param4 below).
> >  
> >    If set to zero, legacy behavior is mimicked where the type of
> >    injection specifies just one bit set, and param1 is multiplexed.
> > @@ -121,7 +127,7 @@ BIOS versions based on the ACPI 5.0 specification have more control over
> >  the target of the injection. For processor-related errors (type 0x1, 0x2
> >  and 0x4), you can set flags to 0x3 (param3 for bit 0, and param1 and
> >  param2 for bit 1) so that you have more information added to the error
> > -signature being injected. The actual data passed is this:
> > +signature being injected. The actual data passed is this::
> >  
> >  	memory_address = param1;
> >  	memory_address_range = param2;
> > @@ -131,7 +137,7 @@ signature being injected. The actual data passed is this:
> >  For memory errors (type 0x8, 0x10 and 0x20) the address is set using
> >  param1 with a mask in param2 (0x0 is equivalent to all ones). For PCI
> >  express errors (type 0x40, 0x80 and 0x100) the segment, bus, device and
> > -function are specified using param1:
> > +function are specified using param1::
> >  
> >           31     24 23    16 15    11 10      8  7        0
> >  	+-------------------------------------------------+
> > @@ -152,26 +158,26 @@ documentation for details (and expect changes to this API if vendors
> >  creativity in using this feature expands beyond our expectations).
> >  
> >  
> > -An error injection example:
> > +An error injection example::
> >  
> > -# cd /sys/kernel/debug/apei/einj
> > -# cat available_error_type		# See which errors can be injected
> > -0x00000002	Processor Uncorrectable non-fatal
> > -0x00000008	Memory Correctable
> > -0x00000010	Memory Uncorrectable non-fatal
> > -# echo 0x12345000 > param1		# Set memory address for injection
> > -# echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
> > -# echo 0x8 > error_type			# Choose correctable memory error
> > -# echo 1 > error_inject			# Inject now
> > +  # cd /sys/kernel/debug/apei/einj
> > +  # cat available_error_type		# See which errors can be injected
> > +  0x00000002	Processor Uncorrectable non-fatal
> > +  0x00000008	Memory Correctable
> > +  0x00000010	Memory Uncorrectable non-fatal
> > +  # echo 0x12345000 > param1		# Set memory address for injection
> > +  # echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
> > +  # echo 0x8 > error_type			# Choose correctable memory error
> > +  # echo 1 > error_inject			# Inject now
> >  
> > -You should see something like this in dmesg:
> > +You should see something like this in dmesg::
> >  
> > -[22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
> > -[22715.834759] EDAC sbridge MC3: CPU 0: Machine Check Event: 0 Bank 7: 8c00004000010090
> > -[22715.834759] EDAC sbridge MC3: TSC 0
> > -[22715.834759] EDAC sbridge MC3: ADDR 12345000 EDAC sbridge MC3: MISC 144780c86
> > -[22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
> > -[22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
> > +  [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
> > +  [22715.834759] EDAC sbridge MC3: CPU 0: Machine Check Event: 0 Bank 7: 8c00004000010090
> > +  [22715.834759] EDAC sbridge MC3: TSC 0
> > +  [22715.834759] EDAC sbridge MC3: ADDR 12345000 EDAC sbridge MC3: MISC 144780c86
> > +  [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
> > +  [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
> >  
> >  For more information about EINJ, please refer to ACPI specification
> >  version 4.0, section 17.5 and ACPI 5.0, section 18.6.
> > diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
> > index 869badba6d7a..fca854f017d8 100644
> > --- a/Documentation/firmware-guide/acpi/index.rst
> > +++ b/Documentation/firmware-guide/acpi/index.rst
> > @@ -18,6 +18,7 @@ ACPI Support
> >     debug
> >     aml-debugger
> >     apei/output_format
> > +   apei/einj
> >     gpio-properties
> >     i2c-muxes
> >     acpi-lid
> 
> 
> 
> Thanks,
> Mauro

-- 
Cheers,
Changbin Du
