Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17552.36563.460775.131555@cargo.ozlabs.ibm.com>
Date: Thu, 15 Jun 2006 08:33:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
In-Reply-To: <20060614144230.GE26750@localdomain>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614035258.GC6759@monkey.ibm.com>
	<20060614144230.GE26750@localdomain>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch writes:

> Without disabling preemption around the mfspr ... update_stats section
> in these hcall wrappers, you risk updating the stats on the wrong cpu.

I think we are only looking for total counts and times anyway, so it
doesn't really matter which cpu updates the stats, as long as the time
gets accounted on some cpu.  The use of per-cpu counters is just for
better cache behaviour.

Paul.
