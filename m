Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id C57EA2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 08:33:19 +1100 (EST)
Message-ID: <41E6E916.6040408@mvista.com>
Date: Thu, 13 Jan 2005 14:33:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <8A6296CC-65A9-11D9-B612-000393DBC2E8@freescale.com>
In-Reply-To: <8A6296CC-65A9-11D9-B612-000393DBC2E8@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Hall <shall@mvista.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc-i2c.c in 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> Adrian,
>
> I was wondering if you had any opinions on the timeout between 
> transactions in drivers/i2c/busses/mpc-i2c.  Looking at it, we 
> currently set the timeout between transactions to 1 second (HZ).  Any 
> reason its this high?
>
> on 85xx, I'm able to set it to HZ/100 w/o any really issue.


This is just an FYI since I've been in this code recently.  You can 
change the timeout from userspace with an ioctl.  Something like this 
should do it:

static char *usage_msg = "Usage: set_timeout <timeout value>\n";

int main(int argc, char **argv)
{
        uint    timeout;
        int     file;

        if (argc != 2) {
                fprintf(stderr, usage_msg);
                return 1;
        }

        timeout = strtoul(argv[1], NULL, 0);

        if ((file = open("/dev/i2c/0", O_RDWR)) < 0) {
                printf("Can't open device, errno: %d (%s)\n",
                        errno, strerror(errno));
                return 1;
        }

        if (ioctl(file, I2C_TIMEOUT, &timeout) < 0) {
                printf("Can't do TIMEOUT: %s\n", strerror(errno));
                return 1;
        }

        return 0;
}
