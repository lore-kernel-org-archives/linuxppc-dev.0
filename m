Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rr9Dr38zfzDqyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 08:22:35 +1000 (AEST)
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
 by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 u6EMMWlR021257
 (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 22:22:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u6EMMWYZ030252
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 22:22:32 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id u6EMMTwD000810
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 22:22:30 GMT
Date: Fri, 15 Jul 2016 01:22:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [bug report] Linux-2.6.12-rc2
Message-ID: <20160714222224.GA25917@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi PPC Devs,

The patch 1da177e4c3f4: "Linux-2.6.12-rc2" from Apr 16, 2005, leads
to the following static checker warning:

	arch/powerpc/sysdev/ipic.c:783 ipic_set_priority()
	error: buffer overflow 'ipic_info' 95 <= 127

arch/powerpc/sysdev/ipic.c
    36  static struct ipic_info ipic_info[] = {
    37          [1] = {
    38                  .mask   = IPIC_SIMSR_H,
    39                  .prio   = IPIC_SIPRR_C,
    40                  .force  = IPIC_SIFCR_H,
    41                  .bit    = 16,
    42                  .prio_mask = 0,
    43          },

 [ huge 95 element array snipped ]

   500          [94] = {
   501                  .mask   = IPIC_SIMSR_L,
   502                  .prio   = 0,
   503                  .force  = IPIC_SIFCR_L,
   504                  .bit    = 30,
   505          },
   506  };

 [ more code snipped ]

   773  int ipic_set_priority(unsigned int virq, unsigned int priority)
   774  {
   775          struct ipic *ipic = ipic_from_irq(virq);
   776          unsigned int src = virq_to_hw(virq);
   777          u32 temp;
   778  
   779          if (priority > 7)
   780                  return -EINVAL;
   781          if (src > 127)
                    ^^^^^^^^^
We cap this at 127

   782                  return -EINVAL;
   783          if (ipic_info[src].prio == 0)
                    ^^^^^^^^^^^^^^
But we only have 95 elements.  Should the array be larger or should
we >= ARRAY_SIZE(ipic_info) is invalid?

   784                  return -EINVAL;
   785  

regards,
dan carpenter
