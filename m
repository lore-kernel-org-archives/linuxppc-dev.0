Return-Path: <eddie@embeddedarm.com>
Received: from oz.embeddedARM.com (oz.embeddedarm.com [67.40.67.44])
	by ozlabs.org (Postfix) with ESMTP id BBCE0DDFB1
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 07:18:15 +1000 (EST)
Message-ID: <49E8F2D7.3050603@embeddedarm.com>
Date: Fri, 17 Apr 2009 14:21:27 -0700
From: Eddie Dawydiuk <eddie@embeddedarm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Grant Likely <grant.likely@secretlab.ca>
Subject: PowerPC iotable_init equivalent?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

In the past I've worked with ARM architectures where I could setup virtual / 
physical address mappings so I don't have to ioremap then pass around pointers. 
Does PowerPC have an equivalent abstraction? If not whats the recommended approach?

That is, is there a better approach to the following...

volatile static unsigned char *my_reg = NULL;

static inline void read_func() {

	if (!my_reg)
         	my_reg = (unsigned char *)
			ioremap(REG_PHYS_BASE, REG_SIZE);
//do something with the reg
}


static inline void write_func() {

	if (!my_reg)
         	my_reg = (unsigned char *)
			ioremap(REG_PHYS_BASE, REG_SIZE);
//do something with the reg
}

-- 
Best Regards,
________________________________________________________________
  Eddie Dawydiuk, Technologic Systems | voice:  (480) 837-5200
  16525 East Laser Drive 	     | fax:    (480) 837-5300
  Fountain Hills, AZ 85268            | web: www.embeddedARM.com
