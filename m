Return-Path: <VONBOEHN@de.ibm.com>
In-Reply-To: <18528.13965.55621.496788@cargo.ozlabs.ibm.com>
References: <OF2260963C.4B69232D-ONC125746E.0032489D-C125746E.003FD09E@de.ibm.com>	<247666.12345.qm@web33104.mail.mud.yahoo.com>
	<OFD65B3B6C.9A2E5A1E-ONC1257471.002B578F-C1257471.002ECE46@de.ibm.com>
	<18528.13965.55621.496788@cargo.ozlabs.ibm.com>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
To: Paul Mackerras <paulus@samba.org>
Message-ID: <OFACC58111.6BF7549C-ONC1257475.0049CAE4-C1257475.004A45F6@de.ibm.com>
From: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Date: Fri, 27 Jun 2008 15:30:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mark Nelson <markn@au1.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	sanjay3000@yahoo.com, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,


> In my experience, dcbz slows down the hot-cache case because it adds a
> few cycles to the execution time of the inner loop, and on most 64-bit
> PowerPC implementations, it doesn't actually help even in the
> cold-cache case because the store queue does enough write combining

I agree with you that on POWER the dcbz is probably not helping.

On PowerPC my experience is different.
>From what I have seen DCBZ help enormously on 970,PA-Semi and CELL.


Cheers
Gunnar



                                                                           
             Paul Mackerras                                                
             <paulus@samba.org                                             
             >                                                          To 
                                       Gunnar von                          
             24/06/2008 01:49          Boehn/Germany/Contr/IBM@IBMDE       
                                                                        cc 
                                       sanjay3000@yahoo.com, Mark Nelson   
                                       <markn@au1.ibm.com>,                
                                       linuxppc-dev@ozlabs.org, Michael    
                                       Ellerman <ellerman@au1.ibm.com>,    
                                       cbe-oss-dev@ozlabs.org, Arnd        
                                       Bergmann <arnd@arndb.de>            
                                                                   Subject 
                                       Re: [RFC 1/3] powerpc:              
                                       __copy_tofrom_user tweaked for Cell 
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




Gunnar von Boehn writes:

> Interesting points.
> Can you help me to understand where the negative effect of DCBZ does come
> from?

In my experience, dcbz slows down the hot-cache case because it adds a
few cycles to the execution time of the inner loop, and on most 64-bit
PowerPC implementations, it doesn't actually help even in the
cold-cache case because the store queue does enough write combining
that the cache doesn't end up reading the line from memory.  I don't
know whether the Cell PPE can do that, but I could believe that it
can't.

Paul.
