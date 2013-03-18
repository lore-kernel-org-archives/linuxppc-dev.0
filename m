Return-Path: <walken@google.com>
Received: from mail-ie0-x22e.google.com (mail-ie0-x22e.google.com
 [IPv6:2607:f8b0:4001:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBE242C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 22:23:40 +1100 (EST)
Received: by mail-ie0-f174.google.com with SMTP id k10so6636801iea.19
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 04:23:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d2ux2c7w.fsf@linux.vnet.ibm.com>
References: <20130221230558.C201931C1B7@corp2gmr1-1.hot.corp.google.com>
 <87d2ux2c7w.fsf@linux.vnet.ibm.com>
Date: Mon, 18 Mar 2013 04:23:35 -0700
Message-ID: <CANN689H_Q8RBmyuF6hqOB+prZciHTUPudfhs_+y0p2peHwTdTw@mail.gmail.com>
Subject: Re: [patch 2/2] mm: use vm_unmapped_area() on powerpc architecture
From: Michel Lespinasse <walken@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: akpm@linux-foundation.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 18, 2013 at 4:12 AM, Aneesh Kumar K.V
<aneesh.kumar@linux.vnet.ibm.com> wrote:
> how about  ?
>
> static bool slice_scan_available(unsigned long addr,
>                                  struct slice_mask available,
>                                  int end,
>                                  unsigned long *boundary_addr)
> {
>         unsigned long slice;
>         if (addr < SLICE_LOW_TOP) {
>                 slice = GET_LOW_SLICE_INDEX(addr);
>                 *boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
>                 return !!(available.low_slices & (1u << slice));
>         } else {
>                 slice = GET_HIGH_SLICE_INDEX(addr);

>                 if ((slice + end) >= SLICE_NUM_HIGH)
>                         /* loop back in the high slice */
>                         *boundary_addr = SLICE_LOW_TOP;
>                 else
>                         *boundary_addr = (slice + end) << SLICE_HIGH_SHIFT;

I don't mind having this section as an if..else rather than ?:
statement. However, the condition would need to be if (slice == 0 &&
end == 0) or if (slice + end == 0)

This is because the beginning of high slice 0 is at SLICE_LOW_TOP and not at 0,
and the end of high slice 63 is at 64TB not at SLICE_LOW_TOP.

>                 return !!(available.high_slices & (1u << slice));
>         }
> }

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
