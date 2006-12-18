Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17798.6928.378248.28903@cargo.ozlabs.ibm.com>
Date: Mon, 18 Dec 2006 15:37:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: mohan@in.ibm.com
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
In-Reply-To: <20061208045537.GA14626@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

> To overcome this problem, I have created the patch, which
> checks for the condition if the machine is ppc970 based and maxcpus
> kernel parameter is specified. If the condition is met, the default
> distribution server is assigned to be current boot cpu instead of
> assigning from the gserver#s property.

It feels hacky to be basing this sort of thing on the PVR.  I would
like to understand the real problem better.  Is it that we are
sometimes setting default_distrib_server to point to a CPU which is
not running?  If so, why and how?  Is this something that is specific
to the firmware on IBM 970-based blade systems?  Is there in fact a
firmware bug that this works around?  Why don't we see it on non-970
based systems?

Paul.
