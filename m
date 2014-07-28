Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C30491A01A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 13:35:33 +1000 (EST)
Message-ID: <1406518533.8345.1.camel@concordia>
Subject: Re: [PATCH] powerpc: fixing endianness of flash_block_list in
 rtas_flash
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Mon, 28 Jul 2014 13:35:33 +1000
In-Reply-To: <1406310462-23005-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1406310462-23005-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,

On Fri, 2014-07-25 at 12:47 -0500, Thomas Falcon wrote:
> [PATCH] powerpc: fixing endianness of flash_block_list in rtas_flash

Minor nit, but the commit title should use the imperative mood, so eg:

  [PATCH] powerpc: Fix endianness of flash_block_list in rtas_flash

> The function rtas_flash_firmware passes the address of a data structure,
> flash_block_list, when making the update-flash-64-and-reboot rtas call.
> While the endianness of the address is handled correctly, the endianness
> of the data is not.  This patch ensures that the data in flash_block_list
> is big endian when passed to rtas on little endian hosts.

This looks good.

But you can do even better by changing the data types to be explicitly BE, so
eg. length should be __be64 I think.

Then if you build with "make C=2 CF=-D__CHECK_ENDIAN__" and have sparse
installed it will tell you when incorrectly assign from/to the BE types.

cheers
