Return-Path: <ossthema@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6CE7E67B8F
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 22:44:20 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7LCiDFA157244
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 13:44:13 +0100
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7LCk83I130348
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 13:46:08 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7LCiCQT019308
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 13:44:12 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Date: Mon, 21 Aug 2006 14:04:15 +0200
References: <44D99F1A.4080905@de.ibm.com> <20060811211915.GL3233@localdomain>
In-Reply-To: <20060811211915.GL3233@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608211404.16122.ossthema@de.ibm.com>
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

Hi Nathan,

sorry for the delayed answer.

On Friday 11 August 2006 23:19, Nathan Lynch wrote:
> > +static inline long ehea_hcall_9arg_9ret(unsigned long opcode,
> > +					unsigned long arg1,
> > +					unsigned long arg2,
> > +					unsigned long arg3,
> > +					unsigned long arg4,
> > +					unsigned long arg5,
> > +					unsigned long arg6,
> > +					unsigned long arg7,
> > +					unsigned long arg8,
> > +					unsigned long arg9,
> > +					unsigned long *out1,
> > +					unsigned long *out2,
> > +					unsigned long *out3,
> > +					unsigned long *out4,
> > +					unsigned long *out5,
> > +					unsigned long *out6,
> > +					unsigned long *out7,
> > +					unsigned long *out8,
> > +					unsigned long *out9)
> > +{
> > +	long hret = H_SUCCESS;
> > +	int i, sleep_msecs;
> > +
> > +	EDEB_EN(7, "opcode=%lx arg1=%lx arg2=%lx arg3=%lx arg4=%lx "
> > +		"arg5=%lx arg6=%lx arg7=%lx arg8=%lx arg9=%lx",
> > +		opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
> > +		arg8, arg9);
> > +
> > +
> > +	for (i = 0; i < 5; i++) {
> > +		hret = plpar_hcall_9arg_9ret(opcode,
> > +					    arg1, arg2, arg3, arg4,
> > +					    arg5, arg6, arg7, arg8,
> > +					    arg9,
> > +					    out1, out2, out3, out4,
> > +					    out5, out6, out7, out8,
> > +					    out9);
> > +
> > +		if (H_IS_LONG_BUSY(hret)) {
> > +			sleep_msecs = get_longbusy_msecs(hret);
> > +			msleep_interruptible(sleep_msecs);
> > +			continue;
> > +		}
> 
> Looping five times before giving up seems arbitrary and failure-prone
> on busy systems.

This is the number we came up with after having talked to the H_CALL
developers

> 
> Is msleep_interruptible (as opposed to msleep) really appropriate?
> 
> Hope all the callers of this function are in non-atomic context (but I
> wasn't able to find any callers?).
That's our intention.
We did not find a place where it is used in an atomic context. 

> 
> And this function is too big to be inline.
> 
> 

Ok, function is no longer inline
