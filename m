Message-ID: <01ba01bff79b$9ee78db0$1952df8d@SOYANG>
From: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Req. help about SCC2 and SCC3 as ethernet.
Date: Thu, 27 Jul 2000 16:23:54 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all.

I've been working on porting MontaVista Linux-2.2.13-7 kernel to our custom MPC850DE board.

Since 850DE support two ethernet interfaces at SCC2 and SCC3, we tried to make it work.

After some tweaking days, we can get serial on SMC1, port of 8xxrom-0.3.0 and Linux.

Linux comes up with default SCC2 ethernet and can mount NFS filesystem.

After such a success, we removed SCC2 and make SCC3 default ethernet ... then Linux hangs at serial_console_write.

Below are the port pin configuration of our board and code snippets from enet.c and uart.c

/*** SCC2 pin configuration ***/
Port A, 12 ---> Ether_TxD2
Port A, 13 ---> Ether_RxD2
Port A, 6 ---> Ether_TCLK2
Port A, 7 ---> Ether_RCLK2
Port C, 14 ---> RTS2 (TEN2)
Port C, 8 ---> CD2 (REN2)
Port C, 9 ---> CST2 (CLSN2)

/*** SCC3 pin configuration ***/
Port B, 30 ---> Ether_TxD3
Port B, 29 ---> Ether_RxD3
Port A, 4 ---> Ether_TCLK3
Port A, 5 ---> Ether_RCLK3
Port C, 13 ---> RTS3 (TEN3)
Port C, 4 ---> CD3 (REN3)
Port C, 5 ---> CST3 (CLSN3)

/*** SMC1 pin configuration ***/
Port B, 25 ---> SMTxD1
Port B, 24 ---> SMRxD1

/*** register set macros for SCC2, SCC3 and SMC1 from our code ***/
// Ethernet 1 for WAN side SCC3
#define PB_ENET1_RXD    ((uint)0x00000004)
#define PB_ENET1_TXD    ((uint)0x00000002)
#define PA_ENET1_TCLK   ((ushort)0x0800)
#define PA_ENET1_RCLK   ((ushort)0x0400)
#define PC_ENET1_TENA   ((ushort)0x0004)
#define PC_ENET1_CLSN   ((ushort)0x0400)
#define PC_ENET1_RENA   ((ushort)0x0800)

// Ethernet 2 for Local side SCC2
#define PA_ENET2_RXD    ((ushort)0x0004)
#define PA_ENET2_TXD    ((ushort)0x0008)
#define PA_ENET2_TCLK   ((ushort)0x0200)
#define PA_ENET2_RCLK   ((ushort)0x0100)
#define PC_ENET2_TENA   ((ushort)0x0002)
#define PC_ENET2_CLSN   ((ushort)0x0040)
#define PC_ENET2_RENA   ((ushort)0x0080)

// Serial SMC1
#define PB_SMC_SMTXD    ((uint)0x00000040)
#define PB_SMC_SMRXD    ((uint)0x00000080)


TCLK2,3 and RCLK2,3 are linked together.

Some kind people responded me that maybe it's a baud rate generator problem.

Anybody please help me.

Thanks in advance.

Have a nice day.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
