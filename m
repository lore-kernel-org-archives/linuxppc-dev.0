Return-Path: <raja_chidambaram82@yahoo.com>
Received: from web53614.mail.yahoo.com (web53614.mail.yahoo.com
	[206.190.39.181]) by ozlabs.org (Postfix) with SMTP id 65121679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jul 2006 21:10:37 +1000 (EST)
Message-ID: <20060728110356.90311.qmail@web53614.mail.yahoo.com>
Date: Fri, 28 Jul 2006 04:03:56 -0700 (PDT)
From: Raja Chidambaram <raja_chidambaram82@yahoo.com>
Subject: RE:System Ace Driver Hangs.
To: ammubhai@gmail.com, eemingliu@hotmail.com, linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



 Hi all,

   I got the system Ace driver compiled in to linux
2.6.12 but once the board boot's up , the console
shows
 
   Data machine check in kernel mode.
and continously runs the call trace.

when  i debugged the this problem on xsyace driver
codebase the it hangs  at function in & calls call
trace
 
      >adapter.c 
 
 -->   if (XSysAce_Initialize(&SysAce, cfg->DeviceId)
!= XST_SUCCESS)

when further debugged the function XSysAce_Initialize
it call the funtion XSysAce_RegWrite16
       
         >xsyace.c

  -->#if (XPAR_XSYSACE_MEM_WIDTH == 16)
    XSysAce_RegWrite16(InstancePtr->BaseAddress +
XSA_BMR_OFFSET,XSA_BMR_16BIT_MASK);

in further debugging on the function
XSysAce_RegWrite16
shows
       >xsysace_l.c

 --> #if (XPAR_XSYSACE_MEM_WIDTH == 16)
void XSysAce_RegWrite16(u32 Address, u16 Data)
{
    u16 ConvertedData;
                                                      
                                                      
               
    /*
     * The ACE registers are little-endian always.
This code takes the incoming
     * 16-bit and endian converts it, then writes it
to the ACE register.
     */
    XIo_ToLittleEndian16(Data, &ConvertedData);
    XIo_Out(Address, ConvertedData); /***** the
execution 
runs the call trace from this point ******/

}



I beleive their problem with  macro value in
               > xparameters.h

   XPAR_SYSACE_COMPACTFLASH_BASEADDR 0x41800000
 can some one please explain how to specify the 
value for this macro mine is xccace-tq144i System ace
or else is their any other problem to solve.please
help me in this.thanks in advance.
                          
                                       with regards
                                        k.raja 



   
    

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
