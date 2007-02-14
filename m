Return-Path: <johnrose@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E549FDDE37
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 09:28:00 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1EMRv0O001302
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 17:27:57 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1EMRvEl513016
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 15:27:57 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1EMRvUd006054
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 15:27:57 -0700
Subject: Re: [PATCH 2.6.21-rc1] ehea: dynamic add / remove port
From: John Rose <johnrose@austin.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
In-Reply-To: <200702141536.28665.ossthema@de.ibm.com>
References: <200702141536.28665.ossthema@de.ibm.com>
Content-Type: text/plain
Message-Id: <1171491906.30473.3.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 14 Feb 2007 16:25:06 -0600
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <RAISCH@de.ibm.com>,
	Marcus Eder <MEDER@de.ibm.com>, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi-

A few high level comments, then some really insignificant ones.

First, is there a reason why we shouldn't have a sysfs entry/kobject for
each logical port?  How is it possible to determine, from the adapter
sysfs directory, the current number of ports for that adapter?  A port
sysfs directory could include attributes like the OF path to the port,
the state of the port, etc etc.

Second, the probe and remove functions do not communicate whether an add
or remove was successful.  Combine this with the lack of port
information in the adapter sysfs directory, and the userspace tool has
no way of verifying a dynamic add/remove.

+		dn_log_port_id = (u32*)get_property(eth_dn, "ibm,hea-port-no",
+						    NULL);
+		if (!dn_log_port_id) {
+			ehea_error("bad device node: dn_log_port_id=%p",
+				   dn_log_port_id);

Wouldn't this print NULL every time for dn_log_port_id?  Would the OF
path for eth_dn make for a more useful error msg?

+		ehea_info("%s -> logial port id #%d",

Spelling :)

 	if (port_setup_ok)
-		ret = 0;	/* At least some ports are setup correctly */
+		return 0;	/* At least some ports are setup correctly */
 	else
-		ret = -EINVAL;
+		return -EINVAL;

The else is unnecessary.

 static int __devexit ehea_remove(struct ibmebus_dev *dev)
 {
 	struct ehea_adapter *adapter = dev->ofdev.dev.driver_data;
 	u64 hret;
 	int i;
 
-	for (i = 0; i < adapter->num_ports; i++)
+	for (i = 0; i < EHEA_MAX_PORTS; i++)
 		if (adapter->port[i]) {
 			ehea_shutdown_single_port(adapter->port[i]);
 			adapter->port[i] = NULL;
 		}

Else break?

Thanks-
John
