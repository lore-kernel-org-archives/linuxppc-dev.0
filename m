From: Remco Treffkorn <remco@rvt.com>
Reply-To: remco@rvt.com
To: Dan Malek <dan@embeddededge.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 3 Serial issues up for discussion (was: Re: Serial core problems on embedded PPC)
Date: Mon, 29 Jul 2002 12:46:42 -0700
Cc: Tom Rini <trini@kernel.crashing.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.linuxppc.org
References: <20020729174341.GA12964@opus.bloom.county> <20020729181352.27999@192.168.4.1> <3D4592D3.50505@embeddededge.com>
In-Reply-To: <3D4592D3.50505@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200207291246.43134.remco@rvt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday 29 July 2002 12:09, Dan Malek wrote:
...
> or a mix of both.  The problems to solve are drivers fighting over minor
> device numbers and assumptions about the system console.
>

Drivers need not fight about minor numbers. That can be simply handled:

int get_new_serial_minor()
{
    static int minor;

    return minor++;
}

Any serial driver can call this when it initializes a new uart.
Hot pluggable drivers have to hang on to their minors, and
re-use.

--
Remco Treffkorn (RT445)
HAM DC2XT
remco@rvt.com   (831) 685-1201

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
