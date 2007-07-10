Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 269BFDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 03:00:24 +1000 (EST)
Message-ID: <4693BB22.5070303@garzik.org>
Date: Tue, 10 Jul 2007 13:00:18 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2/2] eHEA: Receive SKB Aggregation
References: <200707041209.48658.ossthema@de.ibm.com>
In-Reply-To: <200707041209.48658.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> This patch enables the receive side processing to aggregate TCP packets within
> the HEA device driver. It analyses the packets already received after an
> interrupt arrived and forwards these as chains of SKBs for the same TCP
> connection with modified header field. We have seen a lower CPU load and
> improved throughput for small numbers of parallel TCP connections.
> As this feature is considered as experimental it is switched off by default
> and can be activated via a module parameter.
> 
> Some additional security checks have been added since the last posting.
> 
> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

as noted in comments, we don't need to recreate this in every driver. 
do something more generic.
