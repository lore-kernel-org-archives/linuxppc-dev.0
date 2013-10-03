Return-Path: <michael@ellerman.id.au>
Date: Thu, 3 Oct 2013 15:39:44 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9][v5] powerpc/perf: Define big-endian version of
 perf_mem_data_src
Message-ID: <20131003053944.GD17237@concordia>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1380672911-12812-7-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380672911-12812-7-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 01, 2013 at 05:15:07PM -0700, Sukadev Bhattiprolu wrote:
> perf_mem_data_src is an union that is initialized via the ->val field
> and accessed via the bitmap fields. For this to work on big endian
> platforms, we also need a big-endian represenation of perf_mem_data_src.
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index ca1d90b..846f399 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -19,6 +19,50 @@
>  #include <asm/byteorder.h>
>  
>  /*
> + * Kernel and userspace check for endianness in incompatible ways.
> + * In user space, <endian.h> defines both __BIG_ENDIAN and __LITTLE_ENDIAN
> + * but sets __BYTE_ORDER to one or the other. So user space uses checks are:


Why can't you use __BIG_ENDIAN_BITFIELD ?

cheers
