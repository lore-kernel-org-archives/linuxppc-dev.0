Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17748.15442.906060.210242@cargo.ozlabs.ibm.com>
Date: Fri, 10 Nov 2006 19:46:10 +1100
From: Paul Mackerras <paulus@samba.org>
To: Christoph Raisch <RAISCH@de.ibm.com>
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page
	mapping in 64k page mode
In-Reply-To: <OF75FFAC00.E43450CA-ONC1257222.002A402A-C1257222.002AB9BD@de.ibm.com>
References: <adaodrgb7uq.fsf@cisco.com>
	<OF75FFAC00.E43450CA-ONC1257222.002A402A-C1257222.002AB9BD@de.ibm.com>
Cc: openib-general-bounces@openib.org, linuxppc-dev@ozlabs.org,
	Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Raisch writes:

> The patch is needed. We've seen it on the real system. We did fix it on the
> real system.

I disagree that the ioremap change is needed.

> ...and it conforms to theory... although theory is a bit confusing here.
> 
> let me try to summarize:
> ioremap checks for 64k boundary (actually page boundary)

Actually, ioremap itself already does the calculations that your patch
adds - that is, it generates the offset within the page and the
physical address of the start of the page, does the mapping using the
latter, then adds on the offset to the virtual address of the page and
returns that.

Paul.
