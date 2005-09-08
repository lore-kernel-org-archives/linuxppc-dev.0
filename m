Return-Path: <kumar.gala@freescale.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0C620F0B-92B0-4EBF-BC0C-49FD4D3D4323@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 8 Sep 2005 11:28:54 -0500
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: r13 is non-volatile?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Was looking at merging some code between ppc32 & ppc64 and noticed  
that in ppc32 we consider r13 to be part of the non-volatile register  
set.  Is this really correct?

r13 is suppose to be sdata pointer in ppc32 and system thread id in  
ppc64.  So I'm wondering should we really be considering it NV on ppc32?


PPC32:

#define SAVE_NVGPRS(base)       SAVE_GPR(13, base); SAVE_8GPRS(14,  
base); \
                                 SAVE_10GPRS(22, base)
#define REST_NVGPRS(base)       REST_GPR(13, base); REST_8GPRS(14,  
base); \
                                 REST_10GPRS(22, base)

PPC64:
#define SAVE_NVGPRS(base)       SAVE_8GPRS(14, base); SAVE_10GPRS(22,  
base)
#define REST_NVGPRS(base)       REST_8GPRS(14, base); REST_10GPRS(22,  
base)

- kumar
