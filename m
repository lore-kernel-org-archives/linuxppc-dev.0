Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp14.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A3302C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 21:23:20 +1100 (EST)
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 6 Nov 2013 10:23:14 -0000
Message-ID: <527A183F.7030500@linux.vnet.ibm.com>
Date: Wed, 06 Nov 2013 11:21:51 +0100
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: memcpy optimization for 64bit LE
References: <1383640732-21449-1-git-send-email-felix@linux.vnet.ibm.com>
 <11438.1383718966@ale.ozlabs.ibm.com>
In-Reply-To: <11438.1383718966@ale.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling wrote:
> Philippe Bergheaud <felix@linux.vnet.ibm.com> wrote:
> 
> 
>>Unaligned stores take alignment exceptions on POWER7 running in little-endian.
>>This is a dumb little-endian base memcpy that prevents unaligned stores.
>>It is replaced by the VMX memcpy at boot.
> 
> 
> Is this any faster than the generic version?

The little-endian assembly code of the base memcpy is similar to the code emitted by gcc when compiling the generic memcpy in lib/string.c, and runs at the same speed.
However, a little-endian assembly version of the base memcpy is required (as opposed to a C version), in order to use the self-modifying code instrumentation system.
After the cpu feature CPU_FTR_ALTIVEC is detected at boot, the slow base memcpy is nop'ed out, and the fast memcpy_power7 is used instead.

Philippe
