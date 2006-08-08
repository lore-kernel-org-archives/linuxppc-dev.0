Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17624.14147.502469.136322@cargo.ozlabs.ibm.com>
Date: Tue, 8 Aug 2006 17:03:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nicolas DET <nicolas@det-net.org>
Subject: Re: [PATCH] cputable: Correct IBM/750CXe rev3.x setup
In-Reply-To: <20060806104200.49c5f6bf.nicolas@det-net.org>
References: <20060806104200.49c5f6bf.nicolas@det-net.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nicolas DET writes:

> This patch simply add an entry in the cputable to recognize
> correctly the IBM750CXe rev3.1. Only rev 2.x was correctly detected
> before.

[Patch annoyingly as an attachment...]

+	{	/* 750CXe rev 3.1 (0008x311) */
+		.pvr_mask		= 0xffff0fff,
+		.pvr_value		= 0x00080311,
+		.cpu_name		= "750CXe",

Any reason to make this so specific?  The rest of the entry is
identical to the ones we have for PVR values 0x0008221x and
0x00083214 (except that you missed out PPC_FEATURE_PPC_LE).
It looks to me like we could collapse all three into a single entry
with a suitable pvr_mask value (say 0xffff0e00?).

(akpm - consider this a nack)

Paul.
