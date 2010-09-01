Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from echo.usurf.usu.edu (unknown [129.123.194.129])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "echo", Issuer "echo" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5713BB7158
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 07:18:39 +1000 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-net@vger.kernel.org" <linux-net@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: Memory allocation modifications in ibm_newemac driver
Date: Wed, 1 Sep 2010 21:18:36 +0000
Message-ID: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2FBE@Mercury.usurf.usu.edu>
References: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2F09@Mercury.usurf.usu.edu>
In-Reply-To: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2F09@Mercury.usurf.usu.edu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I found out what was causing the crash, but still am not there and could us=
e some direction:=0A=
=0A=
What was happening was that I was not allocating a new SKB to replace the o=
ne in the ring that was being passed up the stack.  I have remedied that an=
d am now having another issue:=0A=
=0A=
Once the ring index rolls over (it does so at 64) I start to lose packets b=
ecause they are not being handled correctly (or do not contain the correct =
headers or something of that sort).  Here is a simple ping test showing wha=
t is happening:=0A=
=0A=
64 bytes from 172.31.22.21: seq=3D29 ttl=3D128 time=3D10.826 ms=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 54 0X1800 110 0XC04E6B80=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 55 0X1800 110 0XC04E6EC0=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 56 0X1800 98 0XC04E70C0=0A=
64 bytes from 172.31.22.21: seq=3D30 ttl=3D128 time=3D10.839 ms=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 57 0X1800 110 0XC04E6580=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 58 0X1800 98 0XC04E5B80=0A=
64 bytes from 172.31.22.21: seq=3D31 ttl=3D128 time=3D10.832 ms=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 59 0X1800 219 0XC04E5740=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 60 0X1800 249 0XC04E5000=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 61 0X1800 92 0XC04E5340=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 62 0X1800 98 0XC04E4A00=0A=
64 bytes from 172.31.22.21: seq=3D32 ttl=3D128 time=3D10.825 ms=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 63 0X5800 92 0XC04E4E00=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 0 0X1800 98 0XC04EF520=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 1 0X1800 92 0XC04D8340=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 2 0X1800 98 0XC04D8260=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 3 0X1800 60 0XC04E7AA0=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 4 0X1800 92 0XC04E74A0=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 5 0X1800 92 0XC04E6BC0=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 6 0X1800 98 0XC04E6F80=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 7 0X1800 92 0XC04E64E0=0A=
emac/plb/opb/ethernet@ef600900: PACKET: 8 0X1800 98 0XC04E5BC0=0A=
=0A=
The first number in my debug print statement is what the driver calls the s=
lot number (the ring index).  When it rolls over I start losing the ping re=
plies.  What have I done wrong to cause that?  The data is coming in and is=
 there.  Have any other network device developers seen similar behavior?=0A=
=0A=
Thanks,=0A=
=0A=
Jonathan=0A=
=0A=
