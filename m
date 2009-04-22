Return-Path: <jacmet@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 7344BDDEF3
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 19:24:07 +1000 (EST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Subject: Re: [MTD] ofpart: Partitions at same address cannot have the same name
References: <1240387541-16594-1-git-send-email-ricardo.ribalda@uam.es>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 22 Apr 2009 11:24:01 +0200
In-Reply-To: <1240387541-16594-1-git-send-email-ricardo.ribalda@uam.es>
	(Ricardo Ribalda Delgado's message of "Wed\,
	22 Apr 2009 10\:05\:41 +0200")
Message-ID: <874owhoxce.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, David.Woodhouse@intel.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Ricardo" == Ricardo Ribalda Delgado <ricardo.ribalda@uam.es> writes:

Hi,

 Ricardo> Sometimes, an special partition is included in the device
 Ricardo> tree including all the partitions. Like in:

 Ricardo>  drivers/mtd/ofpart.c |    3 ++-
 Ricardo>  1 files changed, 2 insertions(+), 1 deletions(-)

 Ricardo> diff --git a/drivers/mtd/ofpart.c b/drivers/mtd/ofpart.c
 Ricardo> index 3e164f0..0af3b07 100644
 Ricardo> --- a/drivers/mtd/ofpart.c
 Ricardo> +++ b/drivers/mtd/ofpart.c
 Ricardo> @@ -48,7 +48,8 @@ int __devinit of_mtd_parse_partitions(struct device *dev,
 
 Ricardo>  		/* check if this is a partition node */
 Ricardo>  		partname = of_get_property(pp, "name", &len);
 Ricardo> -		if (strcmp(partname, "partition") != 0) {
 Ricardo> +		if (strncmp(partname, "partition", strlen("partition")-1)

Why strlen() - 1 ?

-- 
Bye, Peter Korsgaard
