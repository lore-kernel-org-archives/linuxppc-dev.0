Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27A351A028E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 17:01:20 +1100 (AEDT)
Date: Mon, 8 Feb 2016 17:00:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru, thuth@redhat.com,
 lvivier@redhat.com
Subject: Re: [RFCv2 8/9] pseries: Advertise HPT resizing support via CAS
Message-ID: <20160208060020.GH30807@oak.ozlabs.ibm.com>
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-9-git-send-email-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454045043-25545-9-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 29, 2016 at 04:24:02PM +1100, David Gibson wrote:
> The hypervisor needs to know a guest is capable of using the HPT resizing
> PAPR extension in order to make full advantage of it for memory hotplug.
> 
> If the hypervisor knows the guest is HPT resize aware, it can size the
> initial HPT based on the initial guest RAM size, relying on the guest to
> resize the HPT when more memory is hot-added.  Without this, the hypervisor
> must size the HPT for the maximum possible guest RAM, which can lead to
> a huge waste of space if the guest never actually expends to that maximum
> size.
> 
> This patch advertises the guest's support for HPT resizing via the
> ibm,client-architecture-support OF interface.  Obviously, the actual
> encoding in the CAS vector is tentative until the extension is officially
> incorporated into PAPR.  For now we use bit 0 of (previously unused) byte 8
> of option vector 5.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Paul Mackerras <paulus@samba.org>
