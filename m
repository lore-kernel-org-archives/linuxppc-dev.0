Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 64BD8DDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 05:12:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: UartLite for MontaVista - virtex4
Date: Wed, 14 Mar 2007 11:12:55 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE48710862C816@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <WorldClient-F200703131528.AA28530025@linsys.ca>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Jantira Hengmeechai \(Tai\)" <Hengmeej@linsys.ca>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>	Xilinx OS Independent Code XAssert: xuartlite.c:195
>	Code may crash due to unhandled errors.
>	Xilinx OS Independent Code XAssert: xuartlite.c:195
>	Code may crash due to unhandled errors.
>	Xilinx OS Independent Code XAssert: xuartlite.c:195
>	Code may crash due to unhandled errors.
>	Xilinx OS Independent Code XAssert: xuartlite.c:195
>	Code may crash due to unhandled errors.

This code is...

unsigned int XUartLite_Send(XUartLite *InstancePtr, u8 *DataBufferPtr,
                            unsigned int NumBytes)
{
    unsigned int BytesSent;
    u32 StatusRegister;

    /*
     * Assert validates the input arguments
     */
    XASSERT_NONVOID(InstancePtr !=3D NULL);
    XASSERT_NONVOID(DataBufferPtr !=3D NULL);
    XASSERT_NONVOID(InstancePtr->IsReady =3D=3D XCOMPONENT_IS_READY);
    XASSERT_NONVOID(((signed)NumBytes) >=3D 0); // Line 195

There's a patch against the file xuartlite_serial.c to fix a problem
where a backlog of bytes causes NumBytes to be a negative number.
Grab the latest xuartlite_serial.c file from your EDK distribution.

Tim
