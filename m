Message-ID: <403DC009.3030502@ru.mvista.com>
Date: Thu, 26 Feb 2004 12:44:41 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Activating SystemACE support
References: <10318-29667@sneakemail.com>
In-Reply-To: <10318-29667@sneakemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephen,

All this stuff comes from arch/ppc/platforms/xilinx_ocp/xparameters_ml300.h:
#define XPAR_OPB_SYSACE_0_BASEADDR 0xCF000000
#define XPAR_DCR_INTC_0_OPB_SYSACE_0_SYSACE_IRQ_INTR 5
/* Linux Redefines */
#define XPAR_SYSACE_0_BASEADDR XPAR_OPB_SYSACE_0_BASEADDR
#define XPAR_INTC_0_SYSACE_0_VEC_ID XPAR_DCR_INTC_0_OPB_SYSACE_0_SYSACE_IRQ_INTR

In drivers/block/xilinx_sysace/adapter.c:
#define XSA_IRQ (31 - XPAR_INTC_0_SYSACE_0_VEC_ID)
extern XSysAce_Config XSysAce_ConfigTable[];

In drivers/block/xilinx_sysace/xsysace_g.c:
XSysAce_Config XSysAce_ConfigTable[] = {
         {
          XPAR_OPB_SYSACE_0_DEVICE_ID,
          XPAR_OPB_SYSACE_0_BASEADDR}
};

Best regards,
Andrei

Stephen Williams wrote:
>
>
>
> I have a board that, like the Xilinx ml300 board, has a SystemACE
> chip on it. I would like to activate the existing SystemACE drivers
> support in the kernel, but it is not clear to me how I pass to the
> drivers the base address and IRQ that has been assigned. Does anyone
> has any suggestions?
>
> - --
> Steve Williams                "The woods are lovely, dark and deep.
> steve at XXXXXXXXXX           But I have promises to keep,
> http://www.XXXXXXXXXX         and lines to code before I sleep,
> http://www.picturel.com       And lines to code before I sleep."
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
