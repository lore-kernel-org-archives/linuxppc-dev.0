Message-ID: <3E3900B9.2C018B48@innomedia.soft.net>
Date: Thu, 30 Jan 2003 16:08:49 +0530
From: Anand Franklin J <franklin@innomedia.soft.net>
Reply-To: anandfranklin_18@yahoo.com
MIME-Version: 1.0
To: ppc_embedded_maillist <linuxppc-embedded@lists.linuxppc.org>
Subject: powerpc.h compatibality for MVL!!!
Content-Type: multipart/mixed;
 boundary="------------817746C4D9B56FF7BA8951E4"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------817746C4D9B56FF7BA8951E4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,
    I am porting the pSOS code to monta vista linux. I am using the
Power PC 405, where in there is powerpc.h file in pSOS which contains
the declarations like powerpcMtrtc(), tbmilisec_dif() etc. Can anybody
tell me the combatible source file and header file in monta vista linux.

with regard's
franklin.




--------------817746C4D9B56FF7BA8951E4
Content-Type: text/plain; charset=us-ascii;
 name="powerpc.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="powerpc.h"

/*----------------------------------------------------------------------------+
|       This source code has been made available to you by IBM on an AS-IS
|       basis.  Anyone receiving this source is licensed under IBM
|       copyrights to use it in any way he or she deems fit, including
|       copying it, modifying it, compiling it, and redistributing it either
|       with or without modifications.  No license under IBM patents or
|       patent applications is to be implied by the copyright license.
|
|       Any user of this software should understand that IBM cannot provide
|       technical support for this software and will not be responsible for
|       any consequences resulting from the use of this software.
|
|       Any person who transfers this source code or any derivative work
|       must include the IBM copyright notice, this paragraph, and the
|       preceding two paragraphs in the transferred software.
|
|       COPYRIGHT   I B M   CORPORATION 1997
|       LICENSED MATERIAL  -  PROGRAM PROPERTY OF I B M
+----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------+
| Author: Maciej P. Tyrlik
| Component: Include file.
| File: powerpc.h
| Purpose: Definitions for PowerPC instrustions callable from C.
| Changes:
| Date:         Comment:
| -----         --------
| 13-Feb-96     Created                                                     MPT
| 20-Apr-96     Completed                                                   MPT
| 24-Apr-96     1.01 added powerpcMfrtc() function and rtc_t structure      MPT
| 30-Apr-96     1.02 added powerpcSpin() function                           MPT
| 02-May-96     1.02 added powerpcMtrtc() function                          MPT
| 09-May-96     1.03 added more functions dealing with cache                MPT
| 22-May-96     1.04 added powerpcWork() function                           MPT
| 19-Jun-96     1.05 added timer_service() function prototype               MPT
| 20-Jun-96     1.06 added powerpcMtexier() function                        MPT
| 06-Aug-97     1.07 added powerpcMfgpr2() and powerpcMfgpr13()             MPT
| 18-Aug-97     1.09 added powerpcMtdbcr()                                  MPT
| 02-Sep-97     1.10 added int_install()                                    MPT
| 02-Sep-97     1.11 added powerpcMtexisr() function                        MPT
| 03-Sep-97     1.12 added powerpcMfexisr() and powerpcMfexier()            MPT
| 03-Sep-97     1.13 added dma write stuff                                  MPT
| 16-Sep-97     1.14 added powerpcSync() function                           MPT
| 17-Nov-97     1.15 added alignment function prototype                     MPT
| 17-Nov-97     1.16 added mode parameter to s1init() function              MPT
| 10-Feb-98     1.17 port to ElPaso pass 1                                  MPT
| 05-Mar-98     1.18 added SCC config, int_enable() and int_disable()       MPT
| 06-Mar-98     1.19 iocr functions removed                                 MPT
| 16-Mar-98     1.20 removed DCR functions into separate include files      MPT
| 17-Jun-98     1.21 added more cache control functions                     MPT
| 20-Jul-98     1.22 added more time base functions                         MPT
| 08-Dec-98     1.23 added another function prototype                       MPT
| 21-Jan-99     1.24 port to Romeo                                          MPT
| 26-May-99     1.25 added powerpcMflr()                                    MPT
| 15-Jun-99     1.26 added np_compare_swap()                                MPT
| 21-Jun-99     1.27 added powerpcMfpvr()                                   MPT
| 20-Jul-99     1.28 added s1kbhit()                                        MPT
| 14-Sep-99     1.29 added PVR (processor version register) definition      TJC
+----------------------------------------------------------------------------*/
#ifndef _powerpc_h_
#define _powerpc_h_

#ifdef __cplusplus
extern "C" {
#endif

/*----------------------------------------------------------------------------+
| Machine State Register Defines.
+----------------------------------------------------------------------------*/
#define PPCMSRWE                0x00040000
#define PPCMSRCE                0x00020000
#define PPCMSRILE               0x00010000
#define PPCMSREE                0x00008000
#define PPCMSRPR                0x00004000
#define PPCMSRME                0x00001000
#define PPCMSRDE                0x00000200
#define PPCMSRIR                0x00000020
#define PPCMSRDR                0x00000010
#define PPCMSRPE                0x00000008
#define PPCMSRPX                0x00000004
#define PPCMSRLE                0x00000001

/*----------------------------------------------------------------------------+
| Serial port defines.
+----------------------------------------------------------------------------*/
#define SER_MODE_RAW            0x00000000
#define SER_MODE_ADD_CR         0x00000001

/*----------------------------------------------------------------------------+
| Defines deling with ticks and system timers.
+----------------------------------------------------------------------------*/
#define TICKS_PER_SEC           100
#define NANO_SEC_PER_TICK       (1000000000/ TICKS_PER_SEC)

/*----------------------------------------------------------------------------+
| Register and clock definitions.
+----------------------------------------------------------------------------*/
typedef struct power_pc_regs {
   unsigned long        gpr[32];
   unsigned long        xer;
   unsigned long        cr;
   unsigned long        ctr;
   unsigned long        lr;
   unsigned long        srr0;
   unsigned long        srr1;
   unsigned long        srr2;
   unsigned long        srr3;
} reg_t;

typedef struct rtc {
   unsigned long       rtcu;
   unsigned long       rtcl;
} rtc_t;

/*----------------------------------------------------------------------------+
| Global variables.
+----------------------------------------------------------------------------*/
extern unsigned long   __bus_speed;
extern unsigned long   __core_speed;
extern unsigned long   __serial_clock;

/*----------------------------------------------------------------------------+
| FUNCTION PROTOTYPES FOR PPC_CALL.S
+----------------------------------------------------------------------------*/
void powerpc_init_scc0(void);
void powerpcIoff(
                                void );

void powerpcDoff(
                                void );

void powerpcIcbi(
     unsigned long              addr );

void powerpcDcbi(
     unsigned long              addr );

void powerpcDcbt(
     unsigned long              addr );

void powerpcIcbt(
     unsigned long              addr );

void powerpcMtCdbcr(
     unsigned long              data );

unsigned long powerpcMfCdbcr(
                                void );

void powerpcDcbf(
     unsigned long              addr );

void powerpcMtmsr(
     unsigned long              new_msr );

void powerpcMtpit(
     unsigned long              new_pit);

void powerpcMttcr(
     unsigned long              new_tcr );

void powerpcMttsr(
     unsigned long              new_tsr );

void powerpcMtdbcr(
     unsigned long              new_tsr );

unsigned long powerpcCntlz(
              unsigned long     value );

unsigned long powerpcMfmsr(
                                void );

unsigned long powerpcMftcr(
                                void );

unsigned long powerpcMfgpr2(
                                void );

unsigned long powerpcMfgpr13(
                                void );

void powerpcHalt(
                                void );

void powerpcSpin(
     unsigned long              cycles );

void powerpcWork(
     unsigned long              cycles );

unsigned long powerpcMftbu(
                                void );

unsigned long powerpcMftbl(
                                void );

unsigned long powerpcMflr(
                                void );

unsigned long powerpcMfpvr(
                                void );

void powerpcMfrtc(
     rtc_t                      *tim );

void powerpcMtrtc(
     rtc_t                      *tim );

void powerpcMtevpr(
     unsigned long              evpr );

void powerpcSync(
                                void );

void powerpcMtsgr(
     unsigned long              new_sgr );

unsigned long powerpcMfsgr(
                                void );

void setgpio_bit(
     unsigned long              gpio_num,
     unsigned long              reg_num,
     unsigned long              bin_num,
     unsigned long              wide_flag,
     unsigned long              data );

int np_compare_swap(
    int                         *value,
    int                         compare,
    int                         swap );


/*----------------------------------------------------------------------------+
| INTERRUPT PROTOTYPES
+----------------------------------------------------------------------------*/
void timer_isr(
                                void );

int timer_setup(
    unsigned long               value,
    unsigned long               vector_base );

void timer_service(
                                void );

void excp_isr(
                                void );

int excp_setup(
    unsigned long               vector_base );

void excp_service(
     int                        exception,
     reg_t                      *registers );

int int_install(
    int                         level,
    void                        (*int_handler)(void *arg),
    void                        *arg );

int int_enable(
    int                         level,
    int                         config_as_critical,
    int                         config_as_positive_level );

int int_configure(
    int                         level,
    int                         config_as_level_sensitive );

int int_disable(
    int                         level );

int ext_isr(
                                void );

int al_isr(
                                void );

unsigned long tbmilisec_dif(
              rtc_t             *tb_end,
              rtc_t             *tb_start );

void powerpcSetebuio4(unsigned long val);
unsigned long powerpcGetebuio4(void);
#ifdef __cplusplus
}
#endif

#endif


--------------817746C4D9B56FF7BA8951E4--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
