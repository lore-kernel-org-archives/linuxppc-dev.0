Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 54D4BDDE29
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 05:09:42 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so741275anc
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Dec 2007 10:09:41 -0800 (PST)
Message-ID: <fa686aa40712031009w37f43b4n1a73d787ee4cbf11@mail.gmail.com>
Date: Mon, 3 Dec 2007 11:09:41 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [POWERPC] Improved documentation of device tree 'ranges'.
In-Reply-To: <20071203174403.C740719B0073@mail119-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071203174403.C740719B0073@mail119-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/3/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
> I was misled by the prior language.  I've attempted to clarify how
> 'ranges' are used, in particular, how to get a 1:1 mapping.
>
> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  Documentation/powerpc/booting-without-of.txt |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index e9a3cb1..aad8bf5 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -711,13 +711,14 @@ define a bus type with a more complex address format, including things
>  like address space bits, you'll have to add a bus translator to the
>  prom_parse.c file of the recent kernels for your bus type.
>
> -The "reg" property only defines addresses and sizes (if #size-cells
> -is non-0) within a given bus. In order to translate addresses upward
> +The "reg" property only defines addresses and sizes (if #size-cells is
> +non-0) within a given bus. In order to translate addresses upward
>  (that is into parent bus addresses, and possibly into CPU physical
>  addresses), all busses must contain a "ranges" property. If the
>  "ranges" property is missing at a given level, it's assumed that
> -translation isn't possible. The format of the "ranges" property for a
> -bus is a list of:
> +translation isn't possible, i.e., the registers are not visible on the
> +parent bus.  The format of the "ranges" property for a bus is a list
> +of:
>
>         bus address, parent bus address, size
>
> @@ -735,6 +736,8 @@ fit in a single 32-bit word.   New 32-bit powerpc boards should use a
>  1/1 format, unless the processor supports physical addresses greater
>  than 32-bits, in which case a 2/1 format is recommended.
>
> +Alternatively, the "ranges" property may be empty, indicating that the
> +registers are visible on the parent bus, with 1:1 address translation.
>
>  2) Note about "compatible" properties
>  -------------------------------------
> --
> 1.5.3.4
>
>
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
