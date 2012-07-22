Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 09:56:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 05/11] arch/powerpc: remove masking top 16 bit of va
 in tlb invalidate
Message-ID: <20120722235610.GE17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:35PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> ISA doc doesn't talk about this. As per ISA doc for a 4K page
> 
>      tlbie RB RS
> 
> " The Abbreviated Virtual Address (AVA) field in register RB must
>   contain bits 14:65 of the virtual address translated by the TLB
>   entry to be invalidated."
> 
> That indicate we should not mask the top 16 bits. So remove the same.

Older versions of the architecture (2.02 and earler) require the
masking, so we can't just unconditionally remove it, since that would
potentially break POWER5 and PPC970.  People are definitely still
running Linux bare-metal on PPC970s (though arguably not on POWER5).

Paul.
