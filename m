From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Bastien Nocera" <hadess@hadess.net>,
	"Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mii-tool support for gmac/sungem
Date: Sun, 22 Sep 2002 23:57:33 +0200
Message-Id: <20020922215733.9005@192.168.4.1>
In-Reply-To: <1032772148.4083.75.camel@bnocera.surrey.redhat.com>
References: <1032772148.4083.75.camel@bnocera.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Rock, it works. Does ethtool work for every card for which the driver
>has an MII interface ?

Except that on pmacs, the interface is powered down about 10 seconds
after you ifconfig it down. This is good for power management of
laptops obviously but means you won't be able to probe for the link
status at that point.

Worse (my fault), sungem in the official tree has a bug that will
cause it to still try to bang the HW if you use the mii ioctls
while the HW is down, thus causing machine check oops'es (that
is fixed in my tree, I still have to send the patch to DaveM)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
