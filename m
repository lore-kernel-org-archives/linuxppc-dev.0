Return-Path: <antonio.dibacco@aruba.it>
Received: from smtpa3.aruba.it (smtpa4.aruba.it [62.149.128.201])
	by ozlabs.org (Postfix) with SMTP id 3C921679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Mar 2006 07:17:24 +1100 (EST)
From: Antonio Di Bacco <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: mii_send error or at least strange
Date: Wed, 15 Mar 2006 21:21:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200603152121.21852.antonio.dibacco@aruba.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I had a look to mii_send code in u-boot/cpu/mpc8xx/fec.c . It supports both 
FEC1 and FEC2 but anyway it seems to write always register mii-data of FEC1, 
look here: 
 
/* send command to phy using mii, wait for result */ 
static uint  mii_send(uint mii_cmd) 
{ 
uint mii_reply; 
volatile fec_t *ep; 
int cnt; 
 
ep = &(((immap_t *)CFG_IMMR)->im_cpm.cp_fec); 
 
ep->fec_mii_data = mii_cmd; /* command to phy */ 
 
/* wait for mii complete */ 
cnt = 0; 
while (!(ep->fec_ievent & FEC_ENET_MII)) { 
if (++cnt > 1000) { 
printf("mii_send STUCK!\n"); 
break; 
} 
} 
mii_reply = ep->fec_mii_data; /* result from phy */ 
ep->fec_ievent = FEC_ENET_MII; /* clear MII complete */ 
#if 0 
printf("%s[%d] %s: sent=0x%8.8x, reply=0x%8.8x\n", 
__FILE__,__LINE__,__FUNCTION__,mii_cmd,mii_reply); 
#endif 
return (mii_reply & 0xffff); /* data read from phy */ 
} 
