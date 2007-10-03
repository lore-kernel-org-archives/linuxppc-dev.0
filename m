Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190])
	by ozlabs.org (Postfix) with ESMTP id BC42ADDEE1
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 02:05:00 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so5373979mue
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 09:04:58 -0700 (PDT)
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] fsl_spi_init: Support non-QE processors
References: <87lkakxky1.fsf@macbook.be.48ers.dk>
	<fa686aa40710030856u74054993q2d73cf18920665f2@mail.gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 03 Oct 2007 18:04:50 +0200
In-Reply-To: <fa686aa40710030856u74054993q2d73cf18920665f2@mail.gmail.com>
	(Grant Likely's message of "Wed\, 3 Oct 2007 09\:56\:34 -0600")
Message-ID: <874ph8xjz1.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

Hi,

 Grant> Why not just:

 Grant>         np = of_find_node_by_type(NULL, "qe");
 Grant> +       if (!np)
 Grant> +               np = of_find_node_by_type(NULL, "soc");
 Grant>         if (!np)
 Grant>                 return -ENODEV;

My first iteration did it like that, but then you don't get a -ENODEV
if the node is missing (and you'll end up using the wrong clock) and
it doesn't support processors with SPI on and off QE (if that
exists/will ever exist).

-- 
Bye, Peter Korsgaard
