Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stbns2jjDzDrSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 23:26:25 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 190so654366pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 05:26:25 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] mm: make processing of movable_node arch-specific
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <1475778995-1420-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1475778995-1420-5-git-send-email-arbab@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-mm@kvack.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <235f2d20-cf84-08df-1fb4-08ee258fdc52@gmail.com>
Date: Tue, 11 Oct 2016 23:26:19 +1100
MIME-Version: 1.0
In-Reply-To: <1475778995-1420-5-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/10/16 05:36, Reza Arbab wrote:
> Currently, CONFIG_MOVABLE_NODE depends on X86_64. In preparation to
> enable it for other arches, we need to factor a detail which is unique
> to x86 out of the generic mm code.
> 
> Specifically, as documented in kernel-parameters.txt, the use of
> "movable_node" should remain restricted to x86:
> 
> movable_node    [KNL,X86] Boot-time switch to enable the effects
>                 of CONFIG_MOVABLE_NODE=y. See mm/Kconfig for details.
> 
> This option tells x86 to find movable nodes identified by the ACPI SRAT.
> On other arches, it would have no benefit, only the undesired side
> effect of setting bottom-up memblock allocation.
> 
> Since #ifdef CONFIG_MOVABLE_NODE will no longer be enough to restrict
> this option to x86, move it to an arch-specific compilation unit
> instead.
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>

Acked-by: Balbir Singh <bsingharora@gmail.com>
