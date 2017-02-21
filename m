Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS4Nr1lM6zDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 13:35:40 +1100 (AEDT)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS4Nq3rX5z9s7s
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 13:35:38 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id s67so4987593pgb.1
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 18:35:38 -0800 (PST)
Date: Tue, 21 Feb 2017 12:35:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 <skiboot@lists.ozlabs.org>
Subject: Re: [RFC PATCH 1/7] powerpc/book3s: Move machine check event
 structure to opal-api.h
Message-ID: <20170221123520.594ad9df@roar.ozlabs.ibm.com>
In-Reply-To: <148764191593.19289.166429326262713768.stgit@jupiter.in.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
 <148764191593.19289.166429326262713768.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Feb 2017 07:21:56 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> +enum MCE_TlbErrorType {
> +	MCE_TLB_ERROR_INDETERMINATE = 0,
> +	MCE_TLB_ERROR_PARITY = 1,
> +	MCE_TLB_ERROR_MULTIHIT = 2,
> +	MCE_TLB_ERROR_TLBIEL_PROG_ERROR = 3,
> +};

The new TLBIE error isn't really a TLB error as such. Not a hardware error.
I added a new "user" type for it.

I don't think we can handle it just by flushing TLB because it can also be
raised in response to invalid non-local tlbie. We could flush all TLBs maybe
but I think also have to advance nip to return to.

> +
> +enum MCE_NestErrorType {
> +	MCE_NEST_ERROR_ABRT_IFETCH = 0,
> +	MCE_NEST_ERROR_ABRT_IFETCH_TABLEWALK = 1,
> +	MCE_NEST_ERROR_ABRT_LOAD = 2,
> +	MCE_NEST_ERROR_ABRT_LOAD_TABLEWALK = 3,
> +};
> +
> +enum MCE_CrespErrorType {
> +	MCE_CRESP_ERROR_BAD_RADDR_IFETCH = 0,
> +	MCE_CRESP_ERROR_BAD_RADDR_IFETCH_TABLEWALK = 1,
> +	MCE_CRESP_ERROR_BAD_RADDR_LOAD = 2,
> +	MCE_CRESP_ERROR_BAD_RADDR_LOAD_TABLEWALK = 3,
> +};
> +
> +enum MCE_FspaceErrorType {
> +	MCE_FSPACE_ERROR_IFETCH = 0,
> +	MCE_FSPACE_ERROR_IFETCH_TABLEWALK = 1,
> +	MCE_FSPACE_ERROR_RADDR_TRANSLATION = 2,
> +	MCE_FSPACE_ERROR_RADDR_LOAD = 3,
> +};
> +
> +enum MCE_AsyncErrorType {
> +	MCE_ASYNC_ERROR_REAL_ADDR_STORE = 0,
> +	MCE_ASYNC_ERROR_NEST_ABRT_STORE = 1,
> +};
> +
> +struct OpalMachineCheckEvent {

Can we have more of a think about this structure and error types
before making it an OPAL API?

Errors don't always fit neatly into a simple classification like
this. For example "async" is not really an error. It's a property
of how the error is reported. The error is a timeout or real
address error. And it's caused by a store. And initiated by nest
or cResp... Other errors are caused by a table walk that was
caused by a store, etc.

I shoehorned these async errors into realaddr/link types in my
patch along with a different severity (i.e., not SYNC). But I
think we can do a lot better with a clean slate for OPAL.

More general thing is, I wonder how much we need to know of the
implementation details in this API? This still seems like it's
unnecessarily split between OS and FW. I think it would be much
nicer if we just return a set of things that the OS can usefully
respond to and have firmware construct the detailed messages for
logging.

That way we'll have much fewer new types of errors we don't know
how to handle, and never have to report unknown error.

Thanks,
Nick
