Date: Tue, 30 Jul 2002 18:03:46 -0500
From: Steven Bytnar <sbytnar@kagi.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: iMac/PowerBook & IIC bus
Message-ID: <20020730230346.GN26374@openprojects.rarcoa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know anything about the IIC bus in the original iMac?
It looks like there's a 74FST3125 4-bit bus switch that allows
access to different IIC buses. One bus, the default bus(?), leads
to the J3/BOTTOM slot. The other bus leads to the J1/TOP. How do
you tell the Cuda/PMU/mem controller chip to switch between the
IIC buses? It seems like there's two to four different
packet/command mechanisms of reading from IIC devices on older
machines using the Cuda chip:
{
char type; /* 1 = ADB_PACKET_PSEUDO, 5 = ADB_PACKET_MACIIC */
char command; /* 0x22 = ADB_PSEUDOCMD_GET_SET_IIC,
                 0x25 = PSEUDOCMD_COMBINED_FORMAT_IIC */
char i2caddress;
...
}

I understand the {ADB_PACKET_PSEUDO, ADB_PSEUDOCMD_GET_SET_IIC, ...}
packet format, but I haven't figured out any of the other combinations.

I think this IIC bus switching mechanism is used on PowerBooks also.

Any help greatly appreciated.

Thanks,
--Steve


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
