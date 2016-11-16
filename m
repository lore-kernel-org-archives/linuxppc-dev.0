Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJmyh42r3zDvR4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:35:56 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGEYAi6075953
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:35:54 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26rr2242s9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 09:35:54 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 07:35:53 -0700
Subject: Re: [bug report] Driver for IBM System i/p VNIC protocol
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20161116122532.GA12147@mwanda>
Cc: linuxppc-dev@lists.ozlabs.org
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Wed, 16 Nov 2016 08:35:49 -0600
MIME-Version: 1.0
In-Reply-To: <20161116122532.GA12147@mwanda>
Content-Type: text/plain; charset=windows-1252
Message-Id: <8eca3290-984a-bff2-2589-9371016b9425@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2016 06:25 AM, Dan Carpenter wrote:
> Hello Thomas Falcon,
>
> The patch 032c5e82847a: "Driver for IBM System i/p VNIC protocol"
> from Dec 21, 2015, leads to the following static checker warning:
>
> 	drivers/net/ethernet/ibm/ibmvnic.c:2957 error_level_write()
> 	why cast 'kstrtoul()?'
>
> drivers/net/ethernet/ibm/ibmvnic.c
>   2946  static ssize_t error_level_write(struct file *file, const char __user *user_buf,
>   2947                                   size_t len, loff_t *ppos)
>   2948  {
>   2949          struct ibmvnic_fw_comp_internal *ras_comp_int = file->private_data;
>   2950          struct ibmvnic_adapter *adapter = ras_comp_int->adapter;
>   2951          int num = ras_comp_int->num;
>   2952          union ibmvnic_crq crq;
>   2953          unsigned long val;
>   2954          char buff[9]; /* decimal max int plus \n and \0 */
>   2955  
>   2956          copy_from_user(buff, user_buf, sizeof(buff));
>
> No error checking.
>
>   2957          val = kstrtoul(buff, 10, NULL);
>
> This is a wrong conversion from simple_strtoul().  The code has clearly
> never been tested.  There are four other buggy untested calls to
> kstrtoul() in this file.
>
>   2958  
>   2959          if (val > 9)
>   2960                  val = 9;
>   2961  
>   2962          memset(&crq, 0, sizeof(crq));
>   2963          crq.control_ras.first = IBMVNIC_CRQ_CMD;
>   2964          crq.control_ras.cmd = CONTROL_RAS;
>   2965          crq.control_ras.correlator = adapter->ras_comps[num].correlator;
>   2966          crq.control_ras.op = IBMVNIC_ERROR_LEVEL;
>   2967          crq.control_ras.level = val;
>   2968          ibmvnic_send_crq(adapter, &crq);
>   2969  
>   2970          return len;
>   2971  }
Thank you for your time and attention, Dan.  I had also noticed these errors, but did not immediately fix it after being told by our firmware team that support had been discontinued for these features.  I plan to remove/fix these soon.

Thanks again,
Tom


> regards,
> dan carpenter
>
