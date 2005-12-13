Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF958688A1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Dec 2005 19:27:48 +1100 (EST)
Message-ID: <439E86DC.4010901@dgt.com.pl>
Date: Tue, 13 Dec 2005 09:31:24 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------030908060608010508080008"
Subject: HZ manipulation
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030908060608010508080008
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

I have 2.4.25 kernel from denx.de and latest uClibc running on mpc8248.
I'm trying to change HZ value, but still have strange results with 
simple test
Recompiling whole uClibc does not change the results.

What could be wrong?

with HZ==1000:
# 
alarm_test                                                                    

alarm fired after 
0.099092s                                                    
slept 0.999769s


with HZ==500:
# 
alarm_test                                                                    

alarm fired after 
0.199622s                                                    
slept 0.999761s

with HZ==100:
# alarm_test
alarm fired after 0.999693s
slept 0.999760s


- here is procesor id :

... by kernel:
# cat /proc/cpuinfo
processor       : 0
cpu             : 8280
core clock      : 400 MHz
CPM  clock      : 200 MHz
bus  clock      : 100 MHz
revision        : 32.20 (pvr 8082 2014)
bogomips        : 266.24

... and by u-boot:
MPC8248 Reset Status: External Soft, External 
Hard                             
                                                                                

MPC8248 Clock 
Configuration                                                    
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 
100-300     
 - dfbrg 1, corecnf 0x1a, busdf 3, cpmdf 1, plldf 0, pllmf 
3                   
 - vco_out  400000000, scc_clk  100000000, brg_clk   
25000000                  
 - cpu_clk  400000000, cpm_clk  200000000, bus_clk  
100000000                  
 - pci_clk   
66666666                                                          
                                                                                

CPU:   MPC8248 (HiP7 Rev 14, Mask 1.0 1K50M) at 400 MHz


- test code included


--------------030908060608010508080008
Content-Type: text/x-csrc;
 name="alarm_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alarm_test.c"

#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/time.h>

static void sighand(int sig)
{
}

int main()
{
 struct timeval tv1, tv2;
 sigset_t set;
    
 sigfillset(&set);
 sigdelset(&set, SIGALRM);
 sigdelset(&set, SIGINT);
          
 signal(SIGALRM, sighand);
 gettimeofday(&tv1, NULL);
 
 alarm(1);
 sigsuspend(&set);
 gettimeofday(&tv2, NULL);
 
 tv1.tv_sec = tv2.tv_sec - tv1.tv_sec - (tv2.tv_usec < tv1.tv_usec);
 tv1.tv_usec = tv2.tv_usec - tv1.tv_usec + (tv2.tv_usec < tv1.tv_usec) * 1000000;
 
 printf("alarm fired after %ld.%06lds\n",tv1.tv_sec, tv1.tv_usec);

 //--------------------
 gettimeofday(&tv1, NULL);
 sleep(1);
 gettimeofday(&tv2, NULL);
 
 tv1.tv_sec = tv2.tv_sec - tv1.tv_sec - (tv2.tv_usec < tv1.tv_usec);
 tv1.tv_usec = tv2.tv_usec - tv1.tv_usec + (tv2.tv_usec < tv1.tv_usec) * 1000000;
 
 printf("slept %ld.%06lds\n",tv1.tv_sec, tv1.tv_usec);
 
 return 0;
}

--------------030908060608010508080008--
