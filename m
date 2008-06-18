Return-Path: <kenneth@southpole.se>
Subject: mpc5121 cache coherency
From: Kenneth Johansson <kenneth@southpole.se>
To: u-boot-users <u-boot-users@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 18 Jun 2008 21:29:51 +0200
Message-Id: <1213817391.27790.27.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have  tried to speed up u-boot by turning on I/D cache during boot. 

It sort of works and gives quite a boost but I'm having problems with
the ethernet driver that no longer works. 

What I'm seeing is that the cpu do not notice the ethernet hardwares
updates that is located in DRAM. Basically what is expected from a cache
incoherent system. 

Now my question is should not the e300 core detect writes to the DRAM
and reload the cached data ?? 

---
To get cache working I'm turning on the MMU and program some BAT
registers to a 1-1 mapping where only DRAM has cache on and all other
memory regions like the IMMR, flash ... has cache off. 
