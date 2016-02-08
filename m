Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D86ED1A028E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 17:01:19 +1100 (AEDT)
Date: Mon, 8 Feb 2016 16:59:54 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [RFCv2 7/9] pseries: Add support for hash table resizing
Message-ID: <20160208055954.GG30807@oak.ozlabs.ibm.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-8-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454045043-25545-8-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 29, 2016 at 04:24:01PM +1100, David Gibson wrote:
> This adds support for using experimental hypercalls to change the size
> of the main hash page table while running as a PAPR guest.  For now these
> hypercalls are only in experimental qemu versions.
> 
> The interface is two part: first H_RESIZE_HPT_PREPARE is used to allocate
> and prepare the new hash table.  This may be slow, but can be done
> asynchronously.  Then, H_RESIZE_HPT_COMMIT is used to switch to the new
> hash table.  This requires that no CPUs be concurrently updating the HPT,
> and so must be run under stop_machine().
> 
> This also adds a debugfs file which can be used to manually control
> HPT resizing or testing purposes.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Paul Mackerras <paulus@samba.org>
