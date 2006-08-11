Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id E659D67BCC
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 07:19:24 +1000 (EST)
Date: Fri, 11 Aug 2006 16:19:15 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Message-ID: <20060811211915.GL3233@localdomain>
References: <44D99F1A.4080905@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44D99F1A.4080905@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi-

Jan-Bernd Themann wrote:
> +static inline long ehea_hcall_9arg_9ret(unsigned long opcode,
> +					unsigned long arg1,
> +					unsigned long arg2,
> +					unsigned long arg3,
> +					unsigned long arg4,
> +					unsigned long arg5,
> +					unsigned long arg6,
> +					unsigned long arg7,
> +					unsigned long arg8,
> +					unsigned long arg9,
> +					unsigned long *out1,
> +					unsigned long *out2,
> +					unsigned long *out3,
> +					unsigned long *out4,
> +					unsigned long *out5,
> +					unsigned long *out6,
> +					unsigned long *out7,
> +					unsigned long *out8,
> +					unsigned long *out9)
> +{
> +	long hret = H_SUCCESS;
> +	int i, sleep_msecs;
> +
> +	EDEB_EN(7, "opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx "
> +		"arg5=%lx arg6=%lx arg7=%lx arg8=%lx arg9=%lx",
> +		opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
> +		arg8, arg9);
> +
> +
> +	for (i = 0; i < 5; i++) {
> +		hret = plpar_hcall_9arg_9ret(opcode,
> +					    arg1, arg2, arg3, arg4,
> +					    arg5, arg6, arg7, arg8,
> +					    arg9,
> +					    out1, out2, out3, out4,
> +					    out5, out6, out7, out8,
> +					    out9);
> +
> +		if (H_IS_LONG_BUSY(hret)) {
> +			sleep_msecs = get_longbusy_msecs(hret);
> +			msleep_interruptible(sleep_msecs);
> +			continue;
> +		}

Looping five times before giving up seems arbitrary and failure-prone
on busy systems.

Is msleep_interruptible (as opposed to msleep) really appropriate?

Hope all the callers of this function are in non-atomic context (but I
wasn't able to find any callers?).

And this function is too big to be inline.
