From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 26 Jun 2003 12:45:29 -0600
To: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
Cc: "'t.vanremortel@ha.be'" <t.vanremortel@ha.be>,
	PPC Mailinglist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: EP405 network interface
Message-ID: <20030626184529.GB25098@host109.fsmlabs.com>
References: <D73A25AA6E54D511AD74009027B1110F3C08ED@ORION>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <D73A25AA6E54D511AD74009027B1110F3C08ED@ORION>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I ended up hard-coding the interface since the 2_4_devel tree was shifting
on EP405 support quite a bit.  Some EP405 boards worked and some didn't.
Once you tell it it definitely has one (unconditionally) it sails along
smoothly.

I also found that booting out of flash does the same thing regardless of
the EP405 board.  I had to initialize the interface via the firmware before
the Linux driver work work.  I wasn't able to hard-code around that one.

Another point to keep in mind - the linux bootloader code will assume clock
rates for everything.  They're not always correct and that screwed up a lot
of things.  You may want to double check those.

} Did you enable the phy in the Board Control Status Register?
}
} -----Original Message-----
} From: Toni Van Remortel [mailto:t.vanremortel@ha.be]
} Sent: Thursday, June 26, 2003 10:01 AM
} To: PPC Mailinglist
} Subject: EP405 network interface
}
}
}
} Hi all,
}
} I cannot get the NIC working on my EP405. I used the ep405_config from
} the linuxppc_2_4_devel tree.
}
} This is a part of the output:
}
} ...
} loop: loaded (max 8 devices)
} eth0: No PHY device found.
} removing net dev
} ...
}
} So it seems that the kernel doesn't find the NIC (but it is there, and
} working, ep-bootloader can use it to download the image).
}
} Anybody an idea?
}
} I already checked the NIC support, and the onboard-IBM NIC support is
} enabled.
}
} Regards,
} --
}                            Toni Van Remortel
}               Wetenschappelijk Medewerker - D-science lab
}                  Tel: 03 205 61 72 - Fax: 03 205 61 95
}                       E-mail: t.vanremortel@ha.be
}
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
